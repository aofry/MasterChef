require 'rubygems'
require 'chef'
require 'chef/knife'
require 'chef/knife/ssh'
require 'chef/node'
require 'yaml'

class PaasWorker
  def initConfig
    @config = YAML.load_file('master.yaml')

    Chef::Config[:node_name]=config['connection']['node_name']
    Chef::Config[:client_key]=config['connection']['client_key']
    Chef::Config[:chef_server_url]=config['connection']['chef_server_url']
    Chef::Config[:https_proxy]=config['hp_office']['https_proxy']
    Chef::Config[:http_proxy]=config['hp_office']['http_proxy']
  end


  def printClients
    Chef::ApiClient.list.each do |cl|
      puts cl.first
    end
  end

  def changeRunList(itemToAdd)
    node = Chef::Node.load('tomcat')
    puts node
    puts node.run_list

    node.run_list << itemToAdd
    node.save
  end

  def loadClient
   #knife = Chef::Knife::ClientList.new
   #knife.run

   homeClient = Chef::ApiClient.load('home')
   puts homeClient
  end

  def setAttributes(attribute)
    node = Chef::Node.load('tomcat')
    puts node
    node.consume_attributes(attribute)
    node.save

    # print all attribute
    #node.each_attribute do |attrib|
    #  puts attrib
    #end
  end

  def ssh
    other_opts = {
        :ssh_user => 'ubuntu',
        :identity_file =>  'c:/users/ofry/Documents/Dropbox/hp/hpcs/aofry_az3.pem'
            #@config['hpcs']['ssl_ca_file']
    }

    #ary = ['name:tomcat', 'ls -la', other_opts]
    ary = ['ssh', 'name:tomcat', 'ls -la']
    #ssh = Chef::Knife::Ssh.new("name:tomcat 'ls -la'")
    ssh = Chef::Knife::Ssh.new(ary)
    ssh.run

  end

end

paasWorker = PaasWorker.new
#paasWorker.initConfig
#paasWorker.setAttributes({"one" => "adi", "three" => "ofry"})

#loadClient
#changeRunList('apache2')

#nrla = Chef::Knife::NodeRunListAdd.new
#nrla.add_to_run_list(node, ['recipe[apache2]'])
#Chef::Knife::NodeRunListAdd.add_to_run_list('tomcat', 'apache2')

paasWorker.ssh
