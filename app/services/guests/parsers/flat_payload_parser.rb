module Guests
  class Parsers::FlatPayloadParser
    def call(payload)
      {
        email: payload[:guest][:email],
        first_name: payload[:guest][:first_name],
        last_name: payload[:guest][:last_name],
        phone: payload[:guest][:phone],
      }
    end
  end
end
