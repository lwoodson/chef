
# It'll make life a little easier down the line :)

case node["platform"]
when "debian", "ubuntu"
  execute "apt-get update"
  %w{apache2 apache2-threaded-dev libapr1-dev libaprutil1-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

when "redhat", "centos", "fedora"
  execute "echo 'stupid redhat'"
end
