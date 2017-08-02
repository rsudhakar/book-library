class AddLendDateToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :lend_date, :date
  end
end
