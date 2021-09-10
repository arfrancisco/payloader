module Reservations
  class Parsers::FlatPayloadParser
    def call(payload)
      indifferent_payload = payload.with_indifferent_access

      {
        code: indifferent_payload[:reservation_code],
        start_date: indifferent_payload[:start_date].to_datetime,
        end_date: indifferent_payload[:end_date].to_datetime,
        number_of_nights: indifferent_payload[:nights].to_i,
        number_of_guests: indifferent_payload[:guests].to_i,
        number_of_adults: indifferent_payload[:adults].to_i,
        number_of_children: indifferent_payload[:children].to_i,
        number_of_infants: indifferent_payload[:infants].to_i,
        status: indifferent_payload[:status],
        currency: indifferent_payload[:currency],
        payout_price: indifferent_payload[:payout_price].to_f,
        security_price: indifferent_payload[:security_price].to_f,
        total_price: indifferent_payload[:total_price].to_f,
        notes: ""
      }
    end
  end
end