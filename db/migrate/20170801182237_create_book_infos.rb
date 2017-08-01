class CreateBookInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :book_infos do |t|
      t.string :name
      t.string :isbn
      t.float :cost

      t.timestamps
    end
  end
end
