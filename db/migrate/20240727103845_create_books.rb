class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :Book_name
      t.string :Author
      t.string :Owner
      t.string :Contact
      t.string :Location
      t.boolean :Availability

      t.timestamps
    end
  end
end
