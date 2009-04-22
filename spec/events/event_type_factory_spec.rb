require File.join(File.dirname(__FILE__), %w[.. spec_helper])

describe MyRhouse::Events::EventTypeFactory do
  
  describe "#create" do    
    it "should create a correct event type for a shutdown notification" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 42, :command_type => 7 ) )
      event.should_not be_nil
      event.should be_instance_of MyRhouse::Events::ShutdownEvent
    end
    
    it "should create a correct generic event for a light" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 42 ) )
      event.should_not be_nil
      event.should be_instance_of MyRhouse::Events::Generic
    end

    it "should create a correct event type for a camera" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 39 ) )
      event.should_not be_nil
      event.should be_instance_of MyRhouse::Events::Generic
    end

  end
end
