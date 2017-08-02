class User < ApplicationRecord
  has_many :books
  has_many :books_users_histories

  def can_lend?
    this_month_books = books_users_histories.where("extract(month from lending_date) = ?", Date.today.month).count
    this_month_books < 10
  end
end
