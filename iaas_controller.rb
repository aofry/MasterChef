require 'rubygems'
require 'fog'
require 'logger'
require 'yaml'

#http://docs.hpcloud.com/bindings/fog/compute/#RequestServerOperations-jumplink-span
#http://rubydoc.info/gems/fog/frames/Fog/Compute/HP/Servers
class IaaSController
  $logger = Logger.new(STDOUT)

  def initialize(name)
    config = YAML.load_file('master.yaml')
    @name = name.capitalize
    #http://rubydoc.info/gems/fog/frames/Fog
    @conn = Fog::Compute.new(
        :provider => "HP",
        :hp_access_key => config['hpcs']['hp_access_key'],
        :hp_secret_key => config['hpcs']['hp_secret_key'],
        :hp_auth_uri => config['hpcs']['hp_auth_uri'],
        :connection_options => {:ssl_ca_file => config['hpcs']['ssl_ca_file'], :proxy => config['hp_office']['http_proxy']},
        :hp_avl_zone => config['hpcs']['hp_avl_zone'],
        :hp_tenant_id => config['hpcs']['hp_tenant_id'])

  end

  def getFarmInfo
    $logger.info(@conn)

    $logger.info(@conn.servers.size)

    #server = @conn.servers.get('1330449')
    server = @conn.servers.get('1387623')
    $logger.info(server.name)
    $logger.info(server.public_ip_address)
    $logger.info(server.ready?)
    $logger.info(server.to_yaml_properties)

  end

  def getIaasInfo
    @conn.flavors.table([:id, :name, :ram, :disk])
    @conn.images.table([:id, :name, :status, :created_at])
  end

  def bootstrapCompute
    response = @conn.create_server(
        "Adi_Ofry_Runtime4",
        100,
        48335,
        {
            'security_groups' => ["adi"],
            'key_name' => "aofry_az3",
        }
    )

    server = response.body['server']
    #
    sleep(5)
    puts server.to_yaml_properties
    puts
    puts server['id']
    puts server['name']
    #
    puts server['state']
    puts server['public_ip_address']

    @serverId = server['id']
  end
end

iaaSController = IaaSController.new("World")

iaaSController.getFarmInfo
#iaaSController.getIaasInfo
#iaaSController.bootstrapCompute

