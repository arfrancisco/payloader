Rails.application.routes.draw do
  get "process_reservations" => "reservations#process"
end
