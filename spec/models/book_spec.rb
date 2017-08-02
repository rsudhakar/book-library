require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:lent_book) { create :book }
  let(:available_book) { create :book, user: nil}
  let(:user) { create :user }

  describe 'lend' do
    context 'book is already lent' do
      it 'should not lend the book' do
        lent_book.lend(user)
        expect(lent_book.user_id).to_not eq(user.id)
      end
    end

    context 'book is available' do
      context 'user has quota' do
        it 'should lend the book' do
          allow(user).to receive(:can_lend?).and_return(true)
          available_book.lend(user)
          available_book.reload
          expect(available_book.user_id).to eq(user.id)
        end
      end

      context 'user does not have quota' do 
        it 'should not lend the book' do
          allow(user).to receive(:can_lend?).and_return(false)
          available_book.lend(user)
          available_book.reload
          expect(available_book.user_id).to_not eq(user.id)
        end
      end
    end
  end
end
