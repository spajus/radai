class AddCoordinatesToSpecialist < ActiveRecord::Migration
  def change
    add_column :specialists, :latitude, :float
    add_column :specialists, :longitude, :float
  end
end
