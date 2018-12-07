class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name , unique: :true
      t.text :description
      t.text :location

      t.timestamps
    end
  end
end
