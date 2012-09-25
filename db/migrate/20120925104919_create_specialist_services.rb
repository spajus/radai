class CreateSpecialistServices < ActiveRecord::Migration
  def change
    create_table :specialist_services do |t|
      t.integer :specialist_id
      t.integer :service_type_id

      t.timestamps
    end
  end
end
