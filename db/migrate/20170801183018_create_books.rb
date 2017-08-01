class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :book_info_id
      t.integer :user_id
      t.integer :serial_no
      t.boolean :damaged
      t.boolean :lost

      t.timestamps
    end
    add_foreign_key :books, :book_infos
    add_foreign_key :books, :users
  end
end
