module Guests
  class Parsers::EmbeddedPayloadParser
    def call(payload)
      {
        email: payload[:reservation][:guest_email],
        first_name: payload[:reservation][:guest_first_name],
        last_name: payload[:reservation][:guest_last_name],
        phone: payload[:reservation][:guest_phone_numbers].join(', '),
      }
    end
  end
end
