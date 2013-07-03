require 'rubygems'
require 'fog'

#http://rubydoc.info/gems/fog/1.1.2/Fog/
conn = Fog::Compute.new(
       :provider      => "HP",       
       #:hp_account_id  => "E181R1S6S3VE62DW75F5",
       :hp_access_key => "E181R1S6S3VE62DW75F5",
       :hp_secret_key => "vZLMu7GOh1W8maefjT0CdrMxrvqRjpn0CN2BbV9M",       
       :hp_auth_uri   => "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",       
       :connection_options => {:ssl_ca_file => "d:/adi/Dropbox/hp/hpcs/aofry_az3.pem"},
       :hp_avl_zone => "az-3.region-a.geo-1",
       :hp_tenant_id => "19441796971990")

puts conn

puts conn.servers.size
#server = conn.servers.get('1753639')
server = conn.servers.get('1330449')
puts server.name
puts server.public_ip_address   


# directory = conn.directories.create(
#   :key    => "fog-demo",
#   :public => false
# )

# file = directory.files.create(
#   :key    => 'WindowsUpdate.log',
#   :body   => File.open("c:/windows/WindowsUpdate.log"),
#   :public => false
# )

# #directory.destroy

# puts file.to_json