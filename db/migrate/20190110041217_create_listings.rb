class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title, presence: true
      t.text :description, presence: true
      t.string :address, presence: true
      t.string :district, presence: true
      t.string :state, presence: true
      t.string :country, presence: true
      t.integer :room, presence: true, :default => 0
      t.integer :bath, presence: true, :default => 0
      t.integer :adult, presence: true, :default => 0
      t.integer :children, presence: true, :default => 0
      t.integer :price, presence: true, :default => 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
