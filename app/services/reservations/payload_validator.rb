module Reservations
  class PayloadValidator
    def call(payload)
      case payload_type(payload)
      when Reservations::PayloadType::FLAT
        return Schemas::FlatPayload
      when Reservations::PayloadType::EMBEDDED
        return Schemas::EmbeddedPayload
      else
        raise 'Unsupported payload type'
      end
    end

    private

    def payload_type(payload)
      check_payload_type = Reservations::PayloadType.new
      
      check_payload_type.call(payload)
    end
  end
end