require File.join(File.dirname(__FILE__), %w[spec_helper])

describe MyRhouse do
  
  before(:each) do
    Rhouse.initialize( :environment => :test, :log_level => :debug )
    @root_dir = File.expand_path( File.join( File.dirname(__FILE__), %w[..] ) )
  end 
  
  it "has a version" do
    Rhouse.version.should =~ /\d+\.\d+\.\d+/
  end 
  
  it "finds things relative to 'lib'" do
    MyRhouse.libpath( *%w[my_rhouse]).should == File.join( @root_dir, %w[lib my_rhouse] )
  end 
      
  it "finds things relative to 'root'" do
    MyRhouse.path("Rakefile").should == File.join( @root_dir, "Rakefile" )
  end
  
end
