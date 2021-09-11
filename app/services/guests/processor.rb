module Guests
  class Processor
    include PayloaderTransaction

    ATTRIBUTES = %i[
      email
      first_name
      last_name
      phone
    ].freeze
    
    def call(payload)
      validated_payload = validate_payload(payload)
      
      return Failure(validated_payload.errors.to_h) unless validated_payload.success?

      parsed_payload = parse_payload(validated_payload)      

      existing_guest = Guest.where(email: parsed_payload[:email]).first

      if existing_guest
        Transactions::Update.new.call(existing_guest.id, parsed_payload.slice(*ATTRIBUTES))
      else
        Transactions::Create.new.call(parsed_payload.slice(*ATTRIBUTES))
      end
    end

    private

    def validate_payload(payload)
      validator = Reservations::PayloadValidator.new.call(payload)
      validated_payload = validator.(payload)
    end

    def parse_payload(payload)
      reservation_payload_parser = Reservations::PayloadParser.new.call(payload)
      reservation_payload_parser.new.call(payload)
    end
  end
end
