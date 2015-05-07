require 'rails_helper'

RSpec.feature 'Friendship feature' do
  before do
    @userOne = FactoryGirl.create(:user)
    @userTwo = FactoryGirl.create(:user)

    sign_in(@userOne)

  end

  context 'with request made' do
    before do
      @friendRequest = FactoryGirl.create(:request, user_id: @userOne, receiver_id: @userTwo)
      visit user_path @userOne
    end

    scenario 'accepts a request' do
      click_link 'accept_friend_request_0'

      expect(flash[:notice]).to have_content(I18n.t(''))
    end
  end

  context 'without request made' do

  end
end