class User < ApplicationRecord
<<<<<<< HEAD
  has_many :books
  has_many :books_users_histories

  def can_lend?
    this_month_books = books_users_histories.where("extract(month from lending_date) = ?", Date.today.month).count
    this_month_books < 10
  end
||||||| merged common ancestors
=======
  has_many :books
  LONG_TIMER_LENDING_CAP = 10
  DEFAULT_LENDING_CAP = 2

  def can_lend?
    books.count < lending_cap
  end

  def lending_cap
    if created_at <= 6.months.ago
      LONG_TIMER_LENDING_CAP
    else
      DEFAULT_LENDING_CAP
    end
  end

  def has_penalty?(book)
		if book.user == self
			book.lend_date < 20.days.ago
		else
			raise Exception.new("Invalid user")
		end
	end
>>>>>>> 4fcd0ed62ac8aad8cbb11106a777c8ec04b50bbf
end
