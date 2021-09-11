class ProcessReservation
  include PayloaderTransaction
  # Controls main flow of the reservation processing
  # Dictates that we should attempt to process a guest record first
  #   before processing the reservation

  def call(payload)
    Reservations::Processor.new.call(payload)
  end
end
