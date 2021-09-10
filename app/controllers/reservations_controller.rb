class ReservationsController < ApplicationController
  def index
    render json: { success: true }
  end
end