require File.join( File.dirname(__FILE__), %w[.. spec_helper] ) 

describe MyRhouse::Plugins::MusicLib do
    
  it "should index the music library correctly" do
    depot = MyRhouse::Plugins::MusicLib.load_depot    
    depot.should have(1).item
    
    artist = depot.keys.first
    albums = depot[artist]
    albums.should have(1).item
    album  = albums.keys.first
    songs  = depot[artist][album]
    songs.should  have(1).item
    title  = songs.keys.first
                
    artist.should == 'A Guy Called Gerald'
    album.should  == 'Saint Germain Lounge Rendez Vous Disc 2'
    title.should  == 'Humanity (Ashley Beedles Love & Compassion Mix)'
    
    song_file = File.basename( songs[title][:uri] ).should == "song_x.mp3"
  end
  
  it "should pull song meta correctly" do
    info = MyRhouse::Plugins::MusicLib.media_info( File.join( File.dirname(__FILE__), %w[.. .. test music], "song_x.mp3" ) )
    info[:album].should     == "Saint Germain Lounge Rendez Vous Disc 2"
    info[:artist].should    == "A Guy Called Gerald"
    info[:title].should     == "Humanity (Ashley Beedles Love & Compassion Mix)"    
    info[:cover].should     be_nil
  end
  
  it "should pull all song meta correctly" do
    info = MyRhouse::Plugins::MusicLib.media_info( File.join( File.dirname(__FILE__), %w[.. .. test music], "song_x.mp3" ), false )
    info[:album].should     == "Saint Germain Lounge Rendez Vous Disc 2"
    info[:artist].should    == "A Guy Called Gerald"
    info[:title].should     == "Humanity (Ashley Beedles Love & Compassion Mix)"    
    info[:cover].should_not be_nil
  end
end