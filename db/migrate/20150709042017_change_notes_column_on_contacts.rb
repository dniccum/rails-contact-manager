class ChangeNotesColumnOnContacts < ActiveRecord::Migration
    def up
        change_column :contacts, :notes, :text
    end

    def down
        change_column :contacts, :notes, :string
    end
end
