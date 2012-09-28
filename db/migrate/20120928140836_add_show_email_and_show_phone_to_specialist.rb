class AddShowEmailAndShowPhoneToSpecialist < ActiveRecord::Migration
  def change
    add_column :specialists, :show_email, :boolean
    add_column :specialists, :show_phone, :boolean
  end
end
