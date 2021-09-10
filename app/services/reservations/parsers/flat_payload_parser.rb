module Reservations
  class Parsers::FlatPayloadParser
    def call(payload)
      validated_payload = Schemas::FlatPayload.call(payload)

      return validated_payload.errors.to_h unless validated_payload.success?

      {
        code: validated_payload[:reservation_code],
        start_date: validated_payload[:start_date].to_datetime,
        end_date: validated_payload[:end_date].to_datetime,
        number_of_nights: validated_payload[:nights].to_i,
        number_of_guests: validated_payload[:guests].to_i,
        number_of_adults: validated_payload[:adults].to_i,
        number_of_children: validated_payload[:children].to_i,
        number_of_infants: validated_payload[:infants].to_i,
        status: validated_payload[:status],
        currency: validated_payload[:currency],
        payout_price: validated_payload[:payout_price].to_f,
        security_price: validated_payload[:security_price].to_f,
        total_price: validated_payload[:total_price].to_f,
        notes: ""
      }
    end
  end
end