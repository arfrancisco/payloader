module Reservations
  class Processors::GuestProcessor
    def call(payload)
      case payload_type(payload)
      when Reservations::PayloadType::FLAT
        return 'FlatGuestPayloadProcessor'
      when Reservations::PayloadType::EMBEDDED
        return 'EmbeddedGuestPayloadProcessor'
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