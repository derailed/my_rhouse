# -----------------------------------------------------------------------------
# Arduino pluggin for switching an led color
# -----------------------------------------------------------------------------
require 'serialport'

module MyRhouse::Plugins
  class Arduino
    
    attr_reader :config
    
    def initialize
      arduino_conf = YAML.load_file( MyRhouse.confpath( 'arduino.yml' ) )
      logger.debug "Establishing arduino connection in <- #{Rhouse.environment} -> environment"      
      @config = arduino_conf[Rhouse.environment]
    end
    
    # Change the blinkm led to either red => 'r', blue => 'b' or green => 'g'
    def blink_light( cmd )
      logger.debug "Sending arduino command `#{cmd}`"
      logger.debug "Config `#{@config.inspect}`"      
      begin
        SerialPort.open( @config['serial_port'], @config['baud_rate'], @config['data_bits'], @config['stop_bits'], SerialPort::NONE ) do |sp|
          sp.write cmd
        end
      rescue => boom
        logger.error boom
      end
    end
    
    def logger
      Rhouse.logger
    end
  end
end