require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'friendship' do
    before do
      @user = FactoryGirl.create(:user)
      @friend = FactoryGirl.create(:user)
    end

    it 'can\'t add nobody' do
      expect {
        Friendship.create(user_id: @user.id, friend_id: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'can\'t be nobody' do
      expect {
        Friendship.create(user_id: nil, friend_id: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'friends can\'t be added twice' do
      expect(
          Friendship.create(:user_id => @user.id, :friend_id => @friend.id)
      ).to be_valid

      expect {
        Friendship.create(:user_id => @user.id, :friend_id => @friend.id)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'people who add you, are added to your friend list' do
      expect(
          Friendship.create(:user_id => @user.id, :friend_id => @friend.id)
      ).to be_valid

      expect(
          Friendship.create(:user_id => @friend.id, :friend_id => @user.id)
      ).to_not be_valid
    end
  end
end
