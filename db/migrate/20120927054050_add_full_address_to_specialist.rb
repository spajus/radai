class AddFullAddressToSpecialist < ActiveRecord::Migration
  def change
    add_column :specialists, :full_address, :string
  end
end
