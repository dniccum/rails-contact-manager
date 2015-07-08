class AddImageToContacts < ActiveRecord::Migration
  def up
      add_column "contacts", "image", :string
  end

  def down
      remove_column "contacts", "image"
  end
end
