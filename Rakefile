# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.
gem 'darkfish-rdoc'
require 'darkfish-rdoc'

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'rhouse'
require 'my_rhouse'

task :default => 'spec:run'

PROJ.name           = 'my_rhouse'
PROJ.authors        = 'Fernand Galiana'
PROJ.email          = 'fernand.galiana@gmail.com'
PROJ.url            = 'FIXME (project homepage)'
PROJ.version        = MyRhouse::VERSION
PROJ.ruby_opts      = %w[-W0]
PROJ.rdoc.opts      = ["-SHN","-f", "darkfish"]

depend_on( 'activerecord'      , '~> 2.2.0' )
depend_on( 'rhouse'            , '~> 0.0.0' )
depend_on( 'logging'           , '>= 0.9.0' )
depend_on( 'rfuzz'             , '>= 0.9'   )
depend_on( 'beanstalk-client'  , '~> 1.0.0' )
depend_on( 'toholio-serialport', '~> 0.7.2' )
depend_on( 'main'              , '~> 2.8.2' )
depend_on( 'id3lib-ruby'       , '~> 0.5.0' )
