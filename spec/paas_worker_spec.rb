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
    items = ["ntp"]
    @paasWorker.changeRunList('tomcat', items)
  end

  it "should update data bag" do
    someBag = {
        "id" => "adi",
        "Full Name" => "ofry",
        "shell" => "/bin/zsh"
    }

    puts @paasWorker.updateDataBag('MyBag', someBag)
  end

  it "should create new data bag" do
    @paasWorker.createDataBag('aaa')

    createdBag = @paasWorker.getDataBag('aaa')

    expect(createdBag).to be_true

    @paasWorker.delDataBag(createdBag)
  end
end
