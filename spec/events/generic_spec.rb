require File.join(File.dirname(__FILE__), %w[.. spec_helper])
require 'ostruct'

describe MyRhouse::Events::Generic do
  
  it "delegates to message correctly" do
    message = Rhouse::EventParser.parse( "\n0 34 9 0 \"&\" 0 35 1 84 20 \"jpg\" 23 \"\" 41 \"10\" 60 \"640\" 61 \"400\" U19 \"L3RtcC9ibGVl\"\n" )
    
    event = MyRhouse::Events::Generic.new( message )
    event.device_id.should    == 35
    event.command_type.should == 1
    event.command_id.should   == 84
    event.parameters.should_not be_nil
    event.parameters.size.should == 6

    event.parameters[23].should    == ""
    event.parameters[41].should    == 10
    event.parameters[20].should    == "jpg"
    event.parameters[60].should    == 640
    event.parameters[61].should    == 400
    event.parameters[19].should    == "/tmp/blee"
  end
end
