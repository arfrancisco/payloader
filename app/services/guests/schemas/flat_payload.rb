module Guests
  Schemas::FlatPayload = Dry::Schema.Params do
    required(:guest).hash do
      required(:first_name).filled(:string)
      required(:last_name).filled(:string)
      required(:email).filled(:string)
      required(:phone).filled(:string)
    end
  end
end
