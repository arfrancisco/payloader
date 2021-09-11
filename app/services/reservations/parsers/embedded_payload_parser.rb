module Reservations
  class Parsers::EmbeddedPayloadParser
    # Parses the raw payload into our own model attributes 

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
        notes: payload[:reservation][:guest_details][:localized_description],
        email: payload[:reservation][:guest_email],
        first_name: payload[:reservation][:guest_first_name],
        last_name: payload[:reservation][:guest_last_name],
        phone: payload[:reservation][:guest_phone_numbers].join(', '),
      }
    end
  end
end

# Embedded Payload sample
# {
#   "reservation": {
#     "code": "XXX12345678",
#     "start_date": "2021-03-12",
#     "end_date": "2021-03-16",
#     "expected_payout_amount": "3800.00",
#     "guest_details": {
#       "localized_description": "4 guests",
#       "number_of_adults": 2,
#       "number_of_children": 2,
#       "number_of_infants": 0
#     },
#     "guest_email": "wayne_woodbridge@bnb.com",
#     "guest_first_name": "Wayne",
#     "guest_last_name": "Woodbridge",
#     "guest_phone_numbers": [
#       "639123456789",
#       "639123456789"
#     ],
#     "listing_security_price_accurate": "500.00",
#     "host_currency": "AUD",
#     "nights": 4,
#     "number_of_guests": 4,
#     "status_type": "accepted",
#     "total_paid_amount_accurate": "4300.00"
#   }
# }
