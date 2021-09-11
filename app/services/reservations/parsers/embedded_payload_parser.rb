module Reservations
  class Parsers::EmbeddedPayloadParser
    def call(payload)
      {
        code: payload[:reservation][:code],
        start_date: payload[:reservation][:start_date].to_datetime,
        end_date: payload[:reservation][:end_date].to_datetime,
        number_of_nights: payload[:reservation][:nights].to_i,
        number_of_guests: payload[:guests].to_i,
        number_of_adults: payload[:reservation][:guest_details][:number_of_adults].to_i,
        number_of_children: payload[:reservation][:guest_details][:number_of_children].to_i,
        number_of_infants: payload[:reservation][:guest_details][:number_of_infants].to_i,
        status: payload[:reservation][:status_type],
        currency: payload[:reservation][:host_currency],
        payout_price: payload[:reservation][:expected_payout_amount].to_f,
        security_price: payload[:reservation][:listing_security_price_accurate].to_f,
        total_price: payload[:reservation][:total_paid_amount_accurate].to_f,
        notes: payload[:reservation][:guest_details][:localized_description]
      }
    end
  end
end
