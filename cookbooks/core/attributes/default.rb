require 'socket'
User = Struct.new(:username, :email, :root, :sudoer) do
  def root?
    root
  end

  def sudoer?
    sudoer
  end

  def home
    if root?
      "/root"
    else
      "/home/#{self}"
    end
  end

  def to_s
    username
  end
end

default[:hostname] = Socket.gethostname

default[:users] = [
  User.new('root', "root@#{hostname}", true, false),
  User.new('lwoodson', 'lance@webmaneuvers.com', false, true)
]
