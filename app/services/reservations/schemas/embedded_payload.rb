module Reservations
  Schemas::EmbeddedPayload = Dry::Schema.Params do
    required(:reservation).hash do
      required(:code).filled(:string)
      required(:start_date).filled(:string)
      required(:end_date).filled(:string)
      required(:nights).filled(:integer)
      required(:number_of_guests).filled(:integer)
      required(:status_type).filled(:string)
      required(:host_currency).filled(:string)
      required(:expected_payout_amount).filled(:float)
      required(:listing_security_price_accurate).filled(:float)
      required(:total_paid_amount_accurate).filled(:float)
      
      required(:guest_details).hash do
        required(:number_of_adults).filled(:integer)
        required(:number_of_children).filled(:integer)
        required(:number_of_infants).filled(:integer)
        required(:localized_description).filled(:string)
      end
    end
  end
end
