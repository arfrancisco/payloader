module Reservations
  class Transactions::Create
    def call(payload)
      Reservation.create(payload)
    end
  end
end