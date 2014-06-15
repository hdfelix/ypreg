class AddHospitalityTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hospitality_type, :string
  end
end
