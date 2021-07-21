class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name, index: true, null: false
      t.decimal :latitude, precision: 8, scale: 6, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false

      t.timestamps
    end
  end
end
