class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.references :user, index: true
      t.references :event, index: true
    end
  end
end
