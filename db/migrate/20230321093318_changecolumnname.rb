class Changecolumnname < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :Commenter, :commenter
  end
end
