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

server = conn.servers.get('1330449')
puts server.name
puts server.public_ip_address

conn.flavors.table([:id, :name, :ram, :disk])

conn.images.table([:id, :name, :status, :created_at])

#new_server = conn.servers.create(
#    :name => "My Shiny Server",
#    :flavor_id => 1,
#    :image_id => 2,
#    :key_name => "aofry_az3",
#    :security_groups => ["adi"]
#)
#new_server.id       # returns the id of the server
#new_server.name     # => "My Shiny Server"
#new_server.state    # returns the state of the server e.g. BUILD
#new_server.private_ip_address   # returns the private ip address
#new_server.public_ip_address   # returns the public ip address, if any assigned