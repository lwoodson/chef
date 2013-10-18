package 'tmux'
package 'libcurl4-openssl-dev'

gem_package "ruby-shadow"

# Note: you might want to seriosuly consider http://community.opscode.com/cookbooks/sudo. 
# But with that you'll want to look into berkshelf. http://berkshelf.com/
# Just a thought :)
template "/etc/sudoers" do
  source "sudoers.erb"
  mode 0440
  owner "root"
  group "root"
end
