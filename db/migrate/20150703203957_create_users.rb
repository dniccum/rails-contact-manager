class CreateUsers < ActiveRecord::Migration
    def up
        create_table :users do |t|
            t.column "first_name", :string, :limit => 25, :null => false
            t.string "last_name", :limit => 50, :null => false
            t.string "email", :null => false
            t.string "password_digest"

            t.timestamps
        end
    end

    def down
        drop_table :users
    end
end
