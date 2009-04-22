require File.join(File.dirname(__FILE__), %w[../spec_helper])

describe MyRhouse::Rules::RuleEngine do
  before( :all ) do
    @engine = MyRhouse::Rules::RuleEngine.new
  end
  
  # TODO Lame !!
  describe "#evaluate" do    
    
    it "should match a rule when a light is dimmed" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 42, :command_id => 184, :parameters => { 76 => 80 } ) )
      Rhouse.logger.should_receive( :info ).once.with( "\n>>> [MATCH] Found Lighting Event Office dimmable light - Dimmed 80\n" )
      @engine.evaluate( event )
    end

    it "should match a rule for a song stop playing" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 22, :command_id => 22 ) )
      Rhouse.logger.should_receive( :info ).once.with( "\n>>> [MATCH] Found Xine Event Xine Player\n" )
      @engine.evaluate( event )
    end

    it "should match a rule when a camera is activated" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 39 ) )
      Rhouse.logger.should_receive( :info ).once.with( "\n>>> [MATCH] Found Camera Event 39\n" )
      @engine.evaluate( event )
    end

    it "should match a rule when a sensor is tripped with context" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 43, :command_id => 1, :parameters => {25 => 1} ), :pimps => true )
      Rhouse.logger.should_receive( :info ).once.with( "\n>>> [MATCH] Found Sensor Event 43 -- 1\n" )
      @engine.evaluate( event )
    end

    it "should match a rule when a sensor is tripped without context" do
      event = MyRhouse::Events::EventTypeFactory.create_event( OpenStruct.new( :device_id => 43, :command_id => 1, :parameters => {25 => 1} ) )
      Rhouse.logger.should_receive( :info ).once.with( "\n>>> [MATCH] Found Sensor Event 43 -- 1\n" )
      @engine.evaluate( event )
    end


  end
end
