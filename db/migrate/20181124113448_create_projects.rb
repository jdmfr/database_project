class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true
      t.string :follows_count

      t.timestamps
    end

    add_column :groups, :follows_count	,:integer, default: 0 
  end
end
