module Reservations
  class PayloadValidator
    # Dictates what schema to use for validating the raw payload 
    #  depending on the payload type

    def call(payload)
      case payload_type(payload)
      when Reservations::PayloadType::FLAT
        return Schemas::FlatPayload
      when Reservations::PayloadType::EMBEDDED
        return Schemas::EmbeddedPayload
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