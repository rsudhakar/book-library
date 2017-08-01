class Book < ApplicationRecord
  belongs_to :book_info
  belongs_to :user
end
