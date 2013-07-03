require 'rubygems'
require 'chef'

Chef::Config[:node_name]='knife-laptop'
Chef::Config[:client_key]='c:/Users/ofry/.chef/knife.pem'
Chef::Config[:chef_server_url]='https://15.185.249.30'
Chef::Config[:https_proxy]='http://rhvwebcachevip.bastion.europe.hp.com:8080'
Chef::Config[:http_proxy]='http://rhvwebcachevip.bastion.europe.hp.com:8080'

Chef::ApiClient.list.each do |cl|
  puts cl.first
end
