class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.integer :number_of_nights
      t.integer :number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.string :status
      t.string :currency
      t.decimal :payout_price
      t.decimal :security_price
      t.decimal :total_price
      t.string :notes
      t.integer :guest_id, null: false

      t.timestamps
    end
  end
end
