module Guests
  class Transactions::Update
    def call(id, payload)
      Guest.update(id, payload)
    end
  end
end