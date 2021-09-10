module Guests
  class Parsers::EmbeddedPayloadParser
    def call(payload)
      validated_payload = Schemas::EmbeddedPayload.call(payload)
      
      return validated_payload.errors.to_h unless validated_payload.success?

      {
        email: validated_payload[:reservation][:guest_email],
        first_name: validated_payload[:reservation][:guest_first_name],
        last_name: validated_payload[:reservation][:guest_last_name],
        phone: validated_payload[:reservation][:guest_phone_numbers].join(', '),
      }
    end
  end
end
