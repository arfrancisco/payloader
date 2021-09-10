module Reservations
  class Processor
    def call(payload)
      payload_parser = Parsers::PayloadParser.new.call(payload)
      parsed_payload = payload_parser.new.call(payload)

    end
  end
end