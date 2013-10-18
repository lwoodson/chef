# Chef Repo

Chef solo cookbooks for my projects/consulting.

## Requirements

```bash
sudo apt-get update
sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool vim
cd /tmp/
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar -xzf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247/
sudo ./configure
sudo make
sudo make install
cd ~
rm -rf /tmp/ruby*
curl -L https://www.opscode.com/chef/install.sh | sudo bash && mkdir /etc/chef
```

## Running
```sudo chef-solo -c config/solo.rb -j config/rails-web.json```

Started from http://www.morethanseven.net/2010/10/30/Chef-hello-world/
