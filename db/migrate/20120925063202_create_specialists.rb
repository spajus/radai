class CreateSpecialists < ActiveRecord::Migration
  def change
    create_table :specialists do |t|
      t.string :title
      t.text :about
      t.string :phone
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
