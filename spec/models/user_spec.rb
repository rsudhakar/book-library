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
end
