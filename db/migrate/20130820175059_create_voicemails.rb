class CreateVoicemails < ActiveRecord::Migration
  def change
    create_table :voicemails do |t|
      t.string :phone_number, :null => false
      t.string :url, :null => false

      t.timestamps
    end
  end
end
