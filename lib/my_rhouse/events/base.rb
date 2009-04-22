require "forwardable"

module MyRhouse::Events
  class Base
    extend Forwardable
    
    attr_reader :message, :context
    
    def_delegators :message, :device_id, :command_type, :command_id, :parameters
    
    def initialize( message, context={} )
      @message = message
      @context = context
    end
    
    # look up device
    def device
      @device ||= Rhouse::Models::Device.find( message.device_id, :include => :template )
    end
    
    def description
      @description ||= device.template.Description
    end
  end
end