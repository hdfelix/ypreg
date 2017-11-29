class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :content
      t.references :user, index: true
      t.references :event, index: true
    end
  end
end
