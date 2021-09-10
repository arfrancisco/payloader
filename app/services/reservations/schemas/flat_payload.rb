module Reservations
  Schemas::FlatPayload = Dry::Schema.Params do
    required(:reservation_code).filled(:string)
    required(:start_date).filled(:string)
    required(:end_date).filled(:string)
    required(:nights).filled(:integer)
    required(:guests).filled(:integer)
    required(:adults).filled(:integer)
    required(:children).filled(:integer)
    required(:infants).filled(:integer)
    required(:status).filled(:string)
    required(:currency).filled(:string)
    required(:payout_price).filled(:float)
    required(:security_price).filled(:float)
    required(:total_price).filled(:float)
  end
end