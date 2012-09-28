class RemoveServiceTypeIdFromSpecialist < ActiveRecord::Migration
  def change
    remove_column :specialists, :service_type_id
  end
end
