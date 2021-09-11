Rails.application.routes.draw do
  post "process_reservations" => "reservations#process"
end
