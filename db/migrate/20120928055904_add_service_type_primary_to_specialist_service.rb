class AddServiceTypePrimaryToSpecialistService < ActiveRecord::Migration
  def change
    add_column :specialist_services, :primary, :boolean
  end
end
