        
module Helpers
  module DataBags
    class << self

      # escape  . -> - and / -> _  
      # so 1.1/3 -> 1-1_3 
      def escape(name)
        n = name.gsub(/\./,'-')
        n.gsub(/\//,'_')
      end
      alias :escape_bagname :escape

    end
  end
end


