# -----------------------------------------------------------------------------
# Checks Beanstalk Queue for incoming device events. When an event is found, it
# processes that event and try to match one of the rules to take appropriate
# action
#
# Author: Fernand
# -----------------------------------------------------------------------------
module MyRhouse
  class HouseRules < Rhouse::Worker
    
    # =========================================================================
    protected
    
      def engine
        @engine ||= MyRhouse::Rules::RuleEngine.new
      end
      
      # Fetch the yaml configuration file
      def configuration_file
        @config_file_name ||= MyRhouse.confpath( "#{config_file_name}.yml" )
      end
      
      # Handle event on queue. Parse event and create an associated event object 
      # for the rules engine to consume.
      def handle_event( event )
        logger.debug "Got Event #{event.inspect}"
        evt        = Rhouse::EventParser.parse( event )
        Rhouse.logger.debug "Parsed event #{evt.inspect}"  
        event_type = MyRhouse::Events::EventTypeFactory.create_event( evt )

        # fire up rule engine
        engine.evaluate( event_type )        
      end  
  end
end