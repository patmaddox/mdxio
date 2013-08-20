class AddContacts < ActiveRecord::Migration
  def change
    create_table(:contacts) do |t|
      t.string :name, :null => false
      t.string :phone_number
      t.string :email
      t.boolean :whitelist, :null => false, :default => false
      t.boolean :blacklist, :null => false, :default => false
    end
  end
end
