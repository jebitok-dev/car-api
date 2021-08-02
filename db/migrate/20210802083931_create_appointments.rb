class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :username
      t.string :model
      t.string :date
      t.integer :user_id

      t.timestamps
    end
  end
end
