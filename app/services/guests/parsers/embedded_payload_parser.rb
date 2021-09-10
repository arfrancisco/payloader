module Guests
  class Parsers::EmbeddedPayloadParser
    def call(payload)
      indifferent_payload = payload.with_indifferent_access

      {
        email: indifferent_payload[:reservation][:guest_email],
        first_name: indifferent_payload[:reservation][:guest_first_name],
        last_name: indifferent_payload[:reservation][:guest_last_name],
        phone: indifferent_payload[:reservation][:guest_phone_numbers].join(', '),
      }
    end
  end
end
