module Guests
  class Parsers::FlatPayloadParser
    def call(payload)
      validated_payload = Schemas::FlatPayload.call(payload)

      return validated_payload.errors.to_h unless validated_payload.success?

      {
        email: validated_payload[:guest][:email],
        first_name: validated_payload[:guest][:first_name],
        last_name: validated_payload[:guest][:last_name],
        phone: validated_payload[:guest][:phone],
      }
    end
  end
end
