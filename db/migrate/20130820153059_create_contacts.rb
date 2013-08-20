class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :phone_number
      t.string :email
      t.boolean :whitelisted, :null => false, :default => false
      t.boolean :blacklisted, :null => false, :default => false
      t.timestamps
    end
  end
end
