class ProcessReservation
  # Controls main flow of the reservation processing
  # Dictates that we should attempt to process a guest record first
  #   before processing the reservation

  def call(payload)
    guest_processor = Guests::Processor.new.call(payload)  
    reservation_processor = Reservations::Processor.new.call(payload)

    guest_processor.new.call(payload)
    reservation_processor.new.call(payload)

    return { result: :ok, status: 200 }
  end
end
