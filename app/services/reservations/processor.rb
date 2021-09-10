module Reservations
  class Processor
    def call(payload)
      reservation_payload_parser = Parsers::PayloadParser.new.call(payload)
      guest_payload_parser = Guests::Parsers::PayloadParser.new.call(payload)
      parsed_reservation_payload = reservation_payload_parser.new.call(payload)
      parsed_guest_payload = guest_payload_parser.new.call(payload)

      existing_guest = Guest.where(email: parsed_guest_payload[:email]).first
      existing_reservation = Reservation.where(code: parsed_reservation_payload[:code]).first

      if existing_guest.nil?
        raise 'Guest record not found'
      end

      if existing_reservation
        Transactions::Update.new.call(existing_reservation.id, parsed_reservation_payload)
      else
        Transactions::Create.new.call(parsed_reservation_payload.merge(guest_id: existing_guest.id))
      end
    end
  end
end