chef_gem "passenger" do
  action :install
end

bash "relax permissions on passenger home dir" do
  user 'root'
  passenger_home = `passenger-config --root`
  code "chmod o+x #{passenger_home}"
end

httpd_conf = File.join('etc', 'apache2', 'httpd.conf')
if File.read(httpd_conf).scan(/Passenger/).empty?
  execute "run phusion passenger installer" do
    command "passenger-install-apache2-module -a"
    user 'root'
  end
end

passenger_root = `passenger-config --root`.strip
default_ruby = `which ruby`.strip
template "/etc/apache2/httpd.conf" do
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables passenger_root: passenger_root, default_ruby: default_ruby
end

# if you start using the gem 'foodcritic' http://www.foodcritic.io/ it'll start complaining about execute.
# http://www.foodcritic.io/#FC048

execute "restart webserver" do
  command "/etc/init.d/apache2 restart"
  user 'root'
end
# chmod o+x `passenger-config --root`
