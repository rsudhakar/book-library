require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

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
