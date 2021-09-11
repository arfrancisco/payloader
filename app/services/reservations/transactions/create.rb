module Reservations
  class Transactions::Create
    include PayloaderTransaction

    def call(payload)
      ActiveRecord::Base.transaction do
        Reservation.create(payload)
      end

      Success(true)
    rescue ActiveRecord::RecordInvalid => e
      Failure(e)
    end
  end
end