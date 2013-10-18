node.default[:users].each do |new_user|  
  unless new_user.root?
    user new_user.username do
      home new_user.home
      shell "/bin/bash"
      supports manage_home: true
      # password1
      password "$1$tBKupeY1$b02PrirIvNfAgkoXj2Lx71"
      action [:create]
    end

    execute "expire user password" do
      command "passwd -e #{new_user}"
    end

    if new_user.sudoer?
      group "sudo" do
        action [:create, :modify]
        members "#{new_user}"
        append true
      end
    end
  end


  ssh_dir = File.join(new_user.home, '.ssh')

  directory ssh_dir do
    owner new_user.username
    group new_user.username
    mode 0700
    recursive true
    action [:create]
  end
 
  unless new_user.root?
    execute "fetch authorized_keys for #{new_user}" do
      cwd ssh_dir
      user new_user.username
      group new_user.username
      command "curl https://github.com/#{new_user}.keys -o authorized_keys"
    end

    execute "chmod authorized_keys" do
      cwd ssh_dir
      command "chmod 0600 authorized_keys"
    end
  end

  private_key = File.join(ssh_dir, 'id_rsa')
  public_key = File.join(ssh_dir, 'id_rsa.pub')
  unless File.exists?(private_key) && File.exists?(public_key)
    execute "generate key for #{new_user}" do
      cwd ssh_dir
      user new_user.username
      group new_user.username
      command "ssh-keygen -P '' -f id_rsa -t rsa -C \"#{new_user.email}\""
    end
  end
end

