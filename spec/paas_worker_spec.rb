require_relative '../paas_worker'

describe PaasWorker do
  before do
    @paasWorker = PaasWorker.new
    @paasWorker.initConfig
  end

  it "should return a blank instance" do
    @paasWorker.printClients
  end

  it "should change runllist for given node" do
    items = ["apache2"]
    #@paasWorker.changeRunList('tomcat', items)
  end
end