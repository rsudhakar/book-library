require 'rails_helper'

RSpec.describe User, type: :model do

	let(:user) {FactoryGirl.create(:user)}
	let(:non_penalised_book) {FactoryGirl.create(:book, user: user, lend_date: Date.today)}
	let(:penalised_book) {FactoryGirl.create(:book, user: user, lend_date: Date.today - 21.days)}
	let(:book_not_of_user) {FactoryGirl.create(:book, lend_date: Date.today)}

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
end
