module Reservations
  class Parsers::FlatPayloadParser
    # Parses the raw payload into our own model attributes 
    
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

# Flat Payload sample
# {
#   "reservation_code": "YYY12345678",
#   "start_date": "2021-04-14",
#   "end_date": "2021-04-18",
#   "nights": 4,
#   "guests": 4,
#   "adults": 2,
#   "children": 2,
#   "infants": 0,
#   "status": "accepted",
#   "guest": {
#   "first_name": "Wayne",
#   "last_name": "Woodbridge",
#   "phone": "639123456789",
#   "email": "wayne_woodbridge@bnb.com"
#   },
#   "currency": "AUD",
#   "payout_price": "4200.00",
#   "security_price": "500",
#   "total_price": "4700.00"
# }