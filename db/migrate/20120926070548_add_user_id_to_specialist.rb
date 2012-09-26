class AddUserIdToSpecialist < ActiveRecord::Migration
  def change
    add_column :specialists, :user_id, :integer
  end
end
