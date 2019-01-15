class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
        t.date :check_in
        t.date :check_out
        t.integer :price
        t.integer :book_by
        t.boolean :booking_status, :default => false
        t.belongs_to :listing
        t.belongs_to :user
        t.timestamps
    end
  end
end
