require 'rails_helper'
RSpec.describe User, type: :model do
  it "should return true if lending count is <= 10 in a month" do
    user = create(:user)
    create_list(:books_users_history,9,user: user, lending_date: Date.today)
    expect(user.can_lend?).to be true
  end

  it "should return false if lending count is > 10 in a month" do
    user = create(:user)
    create_list(:books_users_history,10,user: user, lending_date: Date.today)
    expect(user.can_lend?).to be false
  end
end
