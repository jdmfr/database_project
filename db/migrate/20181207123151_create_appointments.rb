class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.belongs_to :place, foreign_key: true
      t.references :group, foreign_key: true
      t.date :app_date

      t.timestamps
    end
  end
end
