require 'rails_helper'

RSpec.describe "User Logins", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    it '正しい情報でログインができる' do
      login_as(user)
      expect(current_path).to eq(favs_path)
    end

    it '間違った情報でログインができない' do
      visit login_path
      fill_in 'メール', with: user.email
      fill_in 'パスワード', with: 'wrong_password'
      click_button 'ログイン'

      expect(current_path).to eq(sessions_path)
    end
  end
end