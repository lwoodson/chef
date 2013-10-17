node.default[:users].each do |new_user|  
  user new_user do
    home "/home/#{new_user}"
    shell "/bin/bash"
    supports manage_home: true
    password "$1$tBKupeY1$b02PrirIvNfAgkoXj2Lx71"
    action [:remove, :create]
  end

  execute "expire user password" do
    command "passwd -e #{new_user}"
  end

  directory "/home/#{new_user}/.ssh" do
    owner new_user
    group new_user
    mode 0700
    action [:delete, :create]
  end

  execute "fetch keys" do
    cwd "/home/#{new_user}/.ssh"
    user new_user
    group new_user
    command "curl https://github.com/#{new_user}.keys -o authorized_keys"
  end

  execute "chmod keys" do
    cwd "/home/#{new_user}/.ssh"
    command "chmod 0600 authorized_keys"
  end
end

node.default[:sudoers].each do |new_user|
  group "sudo" do
    action [:create, :modify]
    members "#{new_user}"
    append true
  end
end
