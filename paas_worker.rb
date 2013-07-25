require 'rubygems'
require 'chef'
require 'chef/knife'
require 'chef/knife/ssh'
require 'chef/node'
require 'yaml'

class PaasWorker

  def initConfig
    @config = YAML.load_file('./master.yaml')
    Chef::Config[:node_name]=@config['connection']['node_name']
    Chef::Config[:client_key]=@config['connection']['client_key']
    Chef::Config[:chef_server_url]=@config['connection']['chef_server_url']
    Chef::Config[:https_proxy]=@config['hp_office']['https_proxy']
    Chef::Config[:http_proxy]=@config['hp_office']['http_proxy']
    #puts @config
  end

  def printClients
    Chef::ApiClient.list.each do |cl|
      puts cl.first
    end
  end

  def changeRunList(nodeName, itemsToAdd)
    node = Chef::Node.load(nodeName)
    puts node
    puts node.run_list

    itemsToAdd.each do |item|
      node.run_list << item
    end

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
    #http://stackoverflow.com/questions/16826003/invoking-knife-in-a-ruby-class
    MyCLI.option(:disable_editing, :long => "--disable-editing", :boolean => true)

    knife = Chef::Knife.new
    knife.options=MyCLI.options

    #set up client creation arguments and run
    #knife ssh name:tomcat 'ls -l' -x ubuntu -i d:/work/.chef/home.pem -a ipaddress
    #args = ['client', 'list', '--disable-editing' ]
    args = ['ssh', 'name:tomcat', 'ls -l', '-x', 'ubuntu', '-i', 'd:/work/.chef/home.pem', '-a', 'ipaddress']
    new_client = Chef::Knife.run(args, MyCLI.options)
  end

  def getDataBag(bagName)
    Chef::DataBag.load(bagName)
  end

  def updateDataBag(bagName, data)
    #http://wiki.opscode.com/display/chef10/Data+Bags
    databag_item = Chef::DataBagItem.new
    databag_item.data_bag(bagName)
    databag_item.raw_data = data
    databag_item.save
  end

  def createDataBag(bagName)
    bag = Chef::DataBag.new
    bag.name(bagName)
    bag.save
  end

end

class MyCLI
  include Mixlib::CLI
end


paasWorker = PaasWorker.new
paasWorker.initConfig

adi = {
    "id" => "adi",
    "Full Name" => "ofry",
    "shell" => "/bin/zsh"
}

#puts paasWorker.updateDataBag('MyBag', adi)
puts paasWorker.getDataBag('MyBag')
#paasWorker.createDataBag('someNewBag')


#paasWorker.setAttributes({"one" => "adi", "three" => "ofry"})

#loadClient
#changeRunList('tomcat',['apache2'])

#nrla = Chef::Knife::NodeRunListAdd.new
#nrla.add_to_run_list(node, ['recipe[apache2]'])
#Chef::Knife::NodeRunListAdd.add_to_run_list('tomcat', 'apache2')

#paasWorker.ssh
