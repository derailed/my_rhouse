require 'ruleby'

module MyRhouse::Rules
  class RuleEngine
    include Ruleby
    
    # Check if this event triggers any rules
    def evaluate( event )
      engine :house_rules do |engine|
        rules( engine )
        engine.assert( event )
        engine.match
      end
    end
    
    # =========================================================================
    private
    
      # BOZO !! Caching ??
      # Fetch rule book...
      def rules( engine )
        MyRhouse::Rules::HouseRuleBook.new( engine ).rules
      end
    
      # Fetch logger...
      def logger
        Rhouse.logger
      end
    
  end
end