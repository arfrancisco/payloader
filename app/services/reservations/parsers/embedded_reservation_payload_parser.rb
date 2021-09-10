module Reservations
  class Parsers::EmbeddedReservationPayloadParser
    def call(payload)
      indifferent_payload = payload.with_indifferent_access

      {
        code: indifferent_payload[:reservation][:code],
        start_date: indifferent_payload[:reservation][:start_date].to_datetime,
        end_date: indifferent_payload[:reservation][:end_date].to_datetime,
        number_of_nights: indifferent_payload[:reservation][:nights].to_i,
        number_of_guests: indifferent_payload[:guests].to_i,
        number_of_adults: indifferent_payload[:reservation][:guest_details][:number_of_adults].to_i,
        number_of_children: indifferent_payload[:reservation][:guest_details][:number_of_children].to_i,
        number_of_infants: indifferent_payload[:reservation][:guest_details][:number_of_infants].to_i,
        status: indifferent_payload[:reservation][:status_type],
        currency: indifferent_payload[:reservation][:host_currency],
        payout_price: indifferent_payload[:reservation][:expected_payout_amount].to_f,
        security_price: indifferent_payload[:reservation][:listing_security_price_accurate]to_f,
        total_price: indifferent_payload[:reservation][:total_paid_amount_accurate].to_f,
        notes: indifferent_payload[:reservation][:guest_details][:localized_description]
      }
    end
  end
end
