class AddServiceTypeIdToSpecialist < ActiveRecord::Migration
  def change
    add_column :specialists, :service_type_id, :integer
  end
end
