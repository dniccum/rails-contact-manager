class CreateContacts < ActiveRecord::Migration
    def up
        create_table :contacts do |t|
            t.string "first_name", :limit => 50, :null => false
            t.string "last_name", :limit => 50, :null => false
            t.string "email", :limit => 50, :null => true
            t.string "company", :limit => 50, :null => true
            t.string "notes", :null => true
            t.integer "user_id"

            t.timestamps
        end
        add_index("contacts", "user_id")
    end

    def down
        drop_table :contacts
    end
end
