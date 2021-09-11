module Guests
  class Transactions::Update
    include PayloaderTransaction

    def call(id, payload)
      ActiveRecord::Base.transaction do
        Guest.update(id, payload)
      end

      Success(true)
    rescue ActiveRecord::RecordInvalid => e
      Failure(e)
    end
  end
end