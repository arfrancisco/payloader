module Reservations
  class PayloadParser
    # Dictates what parser class to use based on payload type
    
    def call(payload)
      case payload_type(payload)
      when Reservations::PayloadType::FLAT
        return Parsers::FlatPayloadParser
      when Reservations::PayloadType::EMBEDDED
        return Parsers::EmbeddedPayloadParser
      else
        raise UnsupportedPayloadType
      end
    end

    private

    def payload_type(payload)
      check_payload_type = Reservations::PayloadType.new
      
      check_payload_type.call(payload)
    end
  end
end

class UnsupportedPayloadType < StandardError;end
