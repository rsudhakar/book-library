class User < ApplicationRecord
	def has_penalty?(book)
		if book.user == self
			book.lend_date < 20.days.ago
		else
			raise Exception.new("Invalid user")
		end
	end
end
