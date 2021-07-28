class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.string :name
      t.boolean :done
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
