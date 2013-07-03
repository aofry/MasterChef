require 'rubygems'
require 'fog'

class IaaSController
  def initialize(name)
    @name = name.capitalize
    #http://rubydoc.info/gems/fog/1.1.2/Fog/
    @conn = Fog::Compute.new(
        :provider => "HP",
        :hp_access_key => "E181R1S6S3VE62DW75F5",
        :hp_secret_key => "vZLMu7GOh1W8maefjT0CdrMxrvqRjpn0CN2BbV9M",
        :hp_auth_uri => "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
        :connection_options => {:ssl_ca_file => "d:/adi/Dropbox/hp/hpcs/aofry_az3.pem"},
        :hp_avl_zone => "az-3.region-a.geo-1",
        :hp_tenant_id => "19441796971990")

  end

  def getFarmInfo
    puts @conn

    puts @conn.servers.size

    server = @conn.servers.get('1330449')
    puts server.name
    puts server.public_ip_address
  end

  def getIaasInfo
    @conn.flavors.table([:id, :name, :ram, :disk])
    @conn.images.table([:id, :name, :status, :created_at])
  end

  def bootstrapCompute
    new_server = @conn.servers.create(
        :name => "Adi_Ofry_Runtime1",
        :flavor_id => 100,
        :image_id => 48335,
        :key_name => "aofry_az3",
        :security_groups => ["adi"]
    )

    puts.new_server.id # returns the id of the server
    puts.new_server.name # => "My Shiny Server"
    puts.new_server.state # returns the state of the server e.g. BUILD
    puts.new_server.private_ip_address # returns the private ip address
    puts.new_server.public_ip_address # returns the public ip address, if any assigned
  end
end

iaaSController = IaaSController.new("World")

iaaSController.getFarmInfo
#iaaSController.getIaasInfo
iaaSController.bootstrapCompute

