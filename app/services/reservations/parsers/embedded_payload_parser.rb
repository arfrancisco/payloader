module Reservations
  class Parsers::EmbeddedPayloadParser
    def call(payload)
      validated_payload = Schemas::FlatPayload.call(payload)

      return validated_payload.errors.to_h unless validated_payload.success?

      {
        code: validated_payload[:reservation][:code],
        start_date: validated_payload[:reservation][:start_date].to_datetime,
        end_date: validated_payload[:reservation][:end_date].to_datetime,
        number_of_nights: validated_payload[:reservation][:nights].to_i,
        number_of_guests: validated_payload[:guests].to_i,
        number_of_adults: validated_payload[:reservation][:guest_details][:number_of_adults].to_i,
        number_of_children: validated_payload[:reservation][:guest_details][:number_of_children].to_i,
        number_of_infants: validated_payload[:reservation][:guest_details][:number_of_infants].to_i,
        status: validated_payload[:reservation][:status_type],
        currency: validated_payload[:reservation][:host_currency],
        payout_price: validated_payload[:reservation][:expected_payout_amount].to_f,
        security_price: validated_payload[:reservation][:listing_security_price_accurate].to_f,
        total_price: validated_payload[:reservation][:total_paid_amount_accurate].to_f,
        notes: validated_payload[:reservation][:guest_details][:localized_description]
      }
    end
  end
end
