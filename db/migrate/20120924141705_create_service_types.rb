class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.string :title
      t.string :slug
      t.boolean :approved

      t.timestamps
    end
  end
end
