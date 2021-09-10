module Reservations
  class ProcessReservation
    # Controls main flow of the reservation processing
    # Dictates that we should attempt to process a guest record first
    #   before processing the reservation

    def call(payload)
      guest_processor = Processors::GuestProcessor.new.call(payload)  
      reservation_processor = Processors::ReservationProcessor.new.call(payload)

      guest_processor.call(payload)
      reservation_processor.call(payload)

      return { result: :ok, status: 200 }
    end
  end
end
