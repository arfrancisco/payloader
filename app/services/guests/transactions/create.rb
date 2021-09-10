module Guests
  class Transactions::Create
    def call(payload)
      Guest.create(payload)
    end
  end
end