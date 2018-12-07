class ChangeColumnToProjectAndGroup < ActiveRecord::Migration[5.2]
  def change
  	rename_column :projects , :follows_count,:likes_count 
  	rename_column :groups ,  :follows_count , :likes_count 
  end
end
