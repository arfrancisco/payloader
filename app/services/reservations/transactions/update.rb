module Reservations
  class Transactions::Update
    def call(id, payload)
      Reservation.update(id, payload)
    end
  end
end