require 'sinatra'
require './iaas_controller.rb'


iaaSController = IaaSController.new("World")

get '/farmInfo' do
  puts "before getFarmInfo"
  iaaSController.getFarmInfo
end

