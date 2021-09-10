module Reservations
  class Parsers::FlatGuestPayloadParser
    def call(payload)
      indifferent_payload = payload.with_indifferent_access

      {
        email: indifferent_payload[:guest][:email],
        first_name: indifferent_payload[:guest][:first_name],
        last_name: indifferent_payload[:guest][:last_name],
        phone: indifferent_payload[:guest][:phone],
      }
    end
  end
end
