class User < ApplicationRecord
  has_many :books
  LENDING_CAP = 2

  def can_lend?
    books.count < LENDING_CAP
  end
end
