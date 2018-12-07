class ChangeColumnCountToProject < ActiveRecord::Migration[5.2]
  def change
  	change_column :projects , :follows_count ,:integer , default: 0
  end
end
