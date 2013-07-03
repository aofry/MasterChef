require 'sinatra'
require './iaas_controller.rb'

class WebAccess

  def initialize(name)

    get '/farmInfo' do
      puts "before getFarmInfo"
      @iaaSController = IaaSController.new("World")
      @iaaSController.getFarmInfo
    end
  end
end

WebAccess.new("world2")

