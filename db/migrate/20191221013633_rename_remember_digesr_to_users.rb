class RenameRememberDigesrToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :remember_digesr, :remember_digest
  end
end
