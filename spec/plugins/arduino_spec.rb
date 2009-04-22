require File.join( File.dirname(__FILE__), %w[.. spec_helper] ) 

describe MyRhouse::Plugins::Arduino do
  
  before( :each ) do
    @arduino = MyRhouse::Plugins::Arduino.new
  end

  it "should load the configuration correctly" do
    @arduino.config['serial_port'].should == "/dev/tty.usbserial-A6008bE6"
    @arduino.config['baud_rate'].should   == 9600
    @arduino.config['data_bits'].should   == 8
    @arduino.config['stop_bits'].should   == 1
  end
  
  it "should blink the light correctly" do
     SerialPort.should_receive( :open ).once.with( "/dev/tty.usbserial-A6008bE6", 9600, 8, 1, 0 )
     @arduino.blink_light( 'r' )
  end
  
end