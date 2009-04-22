# -----------------------------------------------------------------------------
# Define MyHouse sample rules. This will be invoke when a worker intercepts
# an event. Currently the rules are matched against the device that fired the
# event.
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ruleby'

module MyRhouse::Rules
  class HouseRuleBook < Ruleby::Rulebook
    
    # RHouse rules !!
    def rules
      # Music playing ?
      rule [MyRhouse::Events::Generic, :event, m.description =~ /.*Xine\sPlayer.*/] do |context|
        cmd = case context[:event].command_id.to_i
          when 12 : 'b' # Play Back Completed
          when 58 : 'g' # Start playing
          when 22 : 'r' # Stop playing 
        end          
        MyRhouse::Plugins::Arduino.new.blink_light( cmd ) unless Rhouse.test_env?
        logger.info "\n>>> [MATCH] Found Xine Event #{context[:event].device.Description}\n"
      end        
      
      # A Light was turned on/off or dimmed ?
      rule [MyRhouse::Events::Generic, :event, m.description =~ /.*Light.*/] do |context|
        cmd = case context[:event].command_id.to_i
          when 193 : ["Turned Off", 'r'] # off
          when 192 : ["Turned On", 'g' ] # on
          when 184 : ["Dimmed #{context[:event].parameters[76]}", 'b'] # dimmed
          else [ 'dont-care', 'm' ]
        end          
        MyRhouse::Plugins::Arduino.new.blink_light( cmd.last ) unless Rhouse.test_env?
        
        logger.info "\n>>> [MATCH] Found Lighting Event #{context[:event].device.Description} - #{cmd.first}\n"
      end
      
      # The camera was activated ?
      rule [MyRhouse::Events::Generic, :event, m.description =~ /.*Camera.*/] do |context|          
        MyRhouse::Plugins::Arduino.new.blink_light( 'm' ) unless Rhouse.test_env?   
        logger.info "\n>>> [MATCH] Found Camera Event #{context[:event].device_id}\n"  
      end
      
      # A Sensor was tripped ?
      rule [MyRhouse::Events::Generic, :event, m.description =~ /.*Sensor.*/] do |context|
        event = context[:event]
        logger.info "\n>>> [MATCH] Found Sensor Event #{event.device_id} -- #{event.parameters[25]}\n"  
                
        if event.context[:pimps]
          MyRhouse::Plugins::Arduino.new.blink_light( 'y' ) unless Rhouse.test_env?
        else
          MyRhouse::Plugins::Arduino.new.blink_light( 'm' ) unless Rhouse.test_env?
        end
                            
        # sensor tripped - play a song and do something with the lights
        dimmed = 100
        if event.parameters[25].to_i == 1
          if event.context[:pimps]
            cmd = { 
              :device_id   => 22,
              :command_id  => 37,
              29           => 4,
              41           => 1003,
              42           => 0,
              59           => "\"/home/public/data/audio/Captain Dan & The Scurvy Crew/Rimes of the Hip Hop Mariners/05 It's All About the Booty.mp3\"" 
            }
          else
            cmd = { 
              :device_id   => 22,
              :command_id  => 37,
              29           => 4,
              41           => 1003,
              42           => 0,
              59           => "\"/home/public/data/audio/Barry White/Ultimate Collection/10 Playing Your Game, Baby.mp3\""
            }
            dimmed = 30              
          end
          unless Rhouse.test_env?
            ws_client = Rhouse::WsClient.new
            
            # Play a tune and...
            ws_client.send_cmd( cmd )
            
            # Do something interesting with the lights
            cmd = {
              :device_id  => 28,
              :command_id => 184,
              76          => dimmed 
            }
            ws_client.send_cmd( cmd )
          end          
        end
      end        
    end    

    def logger
      Rhouse.logger
    end
    
  end
end