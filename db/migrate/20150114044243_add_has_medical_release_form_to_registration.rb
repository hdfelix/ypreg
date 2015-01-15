class AddHasMedicalReleaseFormToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :has_medical_release_form, :boolean
  end
end
