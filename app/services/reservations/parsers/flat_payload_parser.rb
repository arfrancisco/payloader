module Reservations
  class Parsers::FlatPayloadParser
    def call(payload)
      {
        code: payload[:reservation_code],
        start_date: payload[:start_date].to_datetime,
        end_date: payload[:end_date].to_datetime,
        number_of_nights: payload[:nights].to_i,
        number_of_guests: payload[:guests].to_i,
        number_of_adults: payload[:adults].to_i,
        number_of_children: payload[:children].to_i,
        number_of_infants: payload[:infants].to_i,
        status: payload[:status],
        currency: payload[:currency],
        payout_price: payload[:payout_price].to_f,
        security_price: payload[:security_price].to_f,
        total_price: payload[:total_price].to_f,
        notes: "",
        email: payload[:guest][:email],
        first_name: payload[:guest][:first_name],
        last_name: payload[:guest][:last_name],
        phone: payload[:guest][:phone],
      }
    end
  end
end