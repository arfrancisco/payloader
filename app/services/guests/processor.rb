module Guests
  class Processor
    include PayloaderTransaction
    
    def call(payload)
      validator = Reservations::PayloadValidator.new.call(payload)
      validated_payload = validator.(payload)

      return Failure(validated_payload.errors.to_h) unless validated_payload.success?

      parser = Parsers::PayloadParser.new.call(validated_payload)
      parsed_payload = parser.new.call(validated_payload)

      existing_guest = Guest.where(email: parsed_payload[:email]).first

      if existing_guest
        Transactions::Update.new.call(existing_guest.id, parsed_payload)
      else
        Transactions::Create.new.call(parsed_payload)
      end
    end
  end
end
