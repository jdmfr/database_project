class AddDesciptionToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :description, :text
  end
end
