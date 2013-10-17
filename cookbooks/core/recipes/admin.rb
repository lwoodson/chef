package 'tmux'
package 'libcurl4-openssl-dev'

gem_package "ruby-shadow"

template "/etc/sudoers" do
  source "sudoers.erb"
  mode 0440
  owner "root"
  group "root"
end
