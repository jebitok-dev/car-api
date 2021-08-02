class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :model
      t.string :reviews
      t.string :price
      t.string :description

      t.timestamps
    end
  end
end