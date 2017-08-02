require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { create :user }
	let(:non_penalised_book) {FactoryGirl.create(:book, user: user, lend_date: Date.today)}
	let(:penalised_book) {FactoryGirl.create(:book, user: user, lend_date: Date.today - 21.days)}
	let(:book_not_of_user) {FactoryGirl.create(:book, lend_date: Date.today)}

  it "should return true if lending count is <= 10 in a month" do
    user = create(:user)
    create_list(:books_users_history,9,user: user, lending_date: Date.today)
    expect(user.can_lend_this_month?).to be true
  end

  it "should return false if lending count is > 10 in a month" do
    user = create(:user)
    create_list(:books_users_history,10,user: user, lending_date: Date.today)
    expect(user.can_lend_this_month?).to be false
  end
  
	describe "User can keep the book without penalty for 20 days" do
		it "User should return the book within 20 days" do
			expect(user.has_penalty?(non_penalised_book)).to be false
		end

		it "User should be penalised for holding book more than 20 days" do
			expect(user.has_penalty?(penalised_book)).to be true
		end

		it "User should be penalised for his book only" do
			expect { user.has_penalty?(book_not_of_user) }.to raise_error(Exception, "Invalid user")
		end
	end

  describe 'can_lend?' do
    context 'user has borrowed less than quota' do
      it 'should return true' do
        create(:book, user: user)
        expect(user.can_lend?).to be_truthy
      end
    end

    context 'user has borrowed upto his quota' do
      it 'should return false' do
        create_list(:book, 2, user: user)
        expect(user.can_lend?).to be_falsey
      end
    end
  end

  describe 'lending_cap' do
    context 'user has been registered for more than 6 months' do
      it 'should return cap for long timers' do
        user.update(created_at: 7.months.ago)
        user.reload
        expect(user.lending_cap).to eq(User::LONG_TIMER_LENDING_CAP)
      end
    end

    context 'user has been registered in the last 6 months' do
      it 'should return default cap' do
        user.update(created_at: 1.month.ago)
        user.reload
        expect(user.lending_cap).to eq(User::DEFAULT_LENDING_CAP)
      end
    end
  end
end
