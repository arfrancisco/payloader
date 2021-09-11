class ReservationsController < ApplicationController
  def process
    ProcessReservation.new.call(params[:payload]) do |process|
      process.success do
        render json: { result: :ok, status: 200 }
      end

      process.failure do |errors|
        render json: { errors: errors, status: 404 }
      end
    end
  end
end