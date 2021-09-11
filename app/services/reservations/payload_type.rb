module Reservations
  class PayloadType
    # Returns the reservation payload variant. Update as needed
    FLAT = :flat
    EMBEDDED = :embedded
    SUPPORTED_TYPES = [
      FLAT,
      EMBEDDED
    ]

    def call(payload)
      return FLAT if payload.key?(:reservation_code) 
      return EMBEDDED if payload.key?(:reservation)
    end
  end
end
