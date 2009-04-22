module MyRhouse::Events
  class EventTypeFactory
    
    # shutdown command type
    def EventTypeFactory.shutdown_id() 7;end
    
    # create appropriate event classes for rule engine consumption
    def EventTypeFactory.create_event( message, context={} )      
      # Is router is going down
      if message.command_type == shutdown_id 
        MyRhouse::Events::ShutdownEvent.new( message ) 
      else
        MyRhouse::Events::Generic.new( message, context )
      end
    end              
  end
end