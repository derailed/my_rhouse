require File.join(File.dirname(__FILE__), %w[spec_helper])

describe MyRhouse::HouseRules do
  
  before(:each) do
    @worker = MyRhouse::HouseRules.new( "Test" )
  end 
  
  it "should load the correct configuration file" do
    @worker.send( :configuration_file ).should == "/Users/fgaliana/work/experiments/rhouse/gems/my_rhouse/config/test.yml"
  end 
   
  it "should process an event correctly" do
    Rhouse::EventParser.should_receive( :parse ).with( "Blee" ).and_return( "Fred")
    MyRhouse::Events::EventTypeFactory.should_receive( :create_event ).with( "Fred" ).and_return( "doh" )
    engine = mock( MyRhouse::Rules::RuleEngine )
    @worker.should_receive( :engine ).once.and_return( engine )
    engine.should_receive( :evaluate ).once.with( "doh" )
    @worker.send( :handle_event, "Blee" )
  end 
end
