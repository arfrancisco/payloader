module Guests
  class Processor
    def call(payload)
      payload_parser = Parsers::PayloadParser.new.call(payload)
      parsed_payload = payload_parser.new.call(payload)

      existing_guest = Guest.where(email: parsed_payload[:email]).first

      if existing_guest
        Transactions::Update.new.call(existing_guest.id, parsed_payload)
      else
        Transactions::Create.new.call(parsed_payload)
      end
    end
  end
end
