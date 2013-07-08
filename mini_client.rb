require 'rubygems'
require 'chef'
require 'chef/knife'
require 'chef/node'
require 'chef/knife/node_run_list_add'

Chef::Config[:node_name]='home'
Chef::Config[:client_key]='d:/work/.chef/home.pem'
Chef::Config[:chef_server_url]='https://15.185.249.30'
#Chef::Config[:https_proxy]='http://rhvwebcachevip.bastion.europe.hp.com:8080'
#Chef::Config[:http_proxy]='http://rhvwebcachevip.bastion.europe.hp.com:8080'

#Chef::ApiClient.list.each do |cl|
#  puts cl.first
#end

#knife = Chef::Knife::ClientList.new
#knife.run

#homeClient = Chef::ApiClient.load('home')
#puts homeClient

node = Chef::Node.load('tomcat')
puts node
puts node.run_list
node.run_list << 'apache2'
node.save

#nrla = Chef::Knife::NodeRunListAdd.new
#nrla.add_to_run_list(node, ['recipe[apache2]'])
#Chef::Knife::NodeRunListAdd.add_to_run_list('tomcat', 'apache2')
