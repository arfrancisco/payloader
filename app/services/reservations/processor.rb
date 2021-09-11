module Reservations
  class Processor
    include PayloaderTransaction
    # Uses a validated and parsed payload to persist a reservation record

    ATTRIBUTES = %i[
      code
      start_date
      end_date
      number_of_nights
      number_of_guests
      number_of_adults
      number_of_children
      number_of_infants
      status
      currency
      payout_price
      security_price
      total_price
      notes
    ].freeze

    def call(payload)
      validated_payload = validate_payload(payload)

      return Failure(validated_payload.errors.to_h) unless validated_payload.success?
       
      parsed_payload = parse_payload(validated_payload)      

      guest = Guest.where(email: parsed_payload[:email]).first
      
      return Failure('Guest record not found') if guest.nil?
      
      existing_reservation = Reservation.where(code: parsed_payload[:code]).first

      if existing_reservation
        Transactions::Update.new.call(existing_reservation.id, parsed_payload.slice(*ATTRIBUTES).merge(guest_id: guest.id))
      else
        Transactions::Create.new.call(parsed_payload.slice(*ATTRIBUTES).merge(guest_id: guest.id))
      end
    rescue UnsupportedPayloadType
      Failure(:unsupported_payload)
    end

    private

    def validate_payload(payload)
      validator = Reservations::PayloadValidator.new.call(payload)
      validated_payload = validator.(payload)
    end

    def parse_payload(payload)
      reservation_payload_parser = PayloadParser.new.call(payload)
      reservation_payload_parser.new.call(payload)
    end
  end
end