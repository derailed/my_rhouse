# -----------------------------------------------------------------------------
# Seek music medial from core installation
# -----------------------------------------------------------------------------
require 'ostruct'
require 'id3lib'

module MyRhouse::Plugins
  class MusicLib
       
    # Fetch music lib configuration based on environment 
    def self.config
      unless @config      
        media_conf = YAML.load_file( MyRhouse.confpath( 'media.yml' ) )      
        @config    = media_conf[Rhouse.environment]
      end
      @config
    end

    # Retrieves media information by parsing ID tag
    def self.media_info( file, shallow=true )
      tag  = ID3Lib::Tag.new( file )
      return { 
        :uri    => file,
        :artist => tag.artist,
        :album  => tag.album,
        :title  => tag.title,
        :cover  => (tag.frame(:APIC) and !shallow) ? tag.frame(:APIC)[:data] : nil
      }
    end

    # Loads all mp3 files in music depot and store is has a hash for artist/album/song
    def self.load_depot( mime="mp3" )
      media_root = File.join( config['music_depot'], '**', "*.#{mime}" )
      Rhouse.logger.debug( "Looking for music media in #{media_root.inspect}" )
      media_files = Dir.glob( media_root )
      
      media_lib = {}
      media_files.map do |music_file| 
        Rhouse.logger.debug( "Loading file #{music_file}")        
        media_info = media_info( music_file )
        store( media_lib, media_info ) if media_info[:artist] and !media_info[:artist].empty?
      end
      media_lib
    end
    
    # Index media lib by artist/album/songs
    def self.store( media_lib, media_info )
      artist = media_info[:artist]
      album  = media_info[:album]
      title  = media_info[:title]
      if media_lib[artist]
        media_lib[artist][album] = {} unless media_lib[artist][album]
        media_lib[artist][album][title] = media_info
      else
        media_lib[artist] = { album => { title => media_info } }
      end
    end        
  end
end