class CreateBooksUsersHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :books_users_histories do |t|
      t.date :lending_date
      t.date :returning_date
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
