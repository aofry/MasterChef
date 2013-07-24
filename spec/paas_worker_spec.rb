require_relative '../paas_worker'

describe PaasWorker do
  it "should return a blank instance" do
    paasWorker = PaasWorker.new
    paasWorker.initConfig

    paasWorker.printClients
  end
end