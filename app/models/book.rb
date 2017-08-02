class Book < ApplicationRecord
  belongs_to :book_info
  belongs_to :user, optional: true

  def lend(lending_user)
    return if (user.present? || !lending_user.can_lend?)

    update(user: lending_user)
  end
end
