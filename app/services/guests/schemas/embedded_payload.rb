module Guests
  Schemas::EmbeddedPayload = Dry::Schema.Params do
    required(:reservation).hash do
      required(:guest_first_name).filled(:string)
      required(:guest_last_name).filled(:string)
      required(:guest_email).filled(:string)
      required(:guest_phone_numbers).array(:str?)
    end
  end
end