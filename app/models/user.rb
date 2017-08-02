class User < ApplicationRecord
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
end
