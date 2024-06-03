require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー新規作成' do
    it 'ユーザーの新規作成ができる' do
      visit new_user_path
      expect {
        fill_in 'ユーザーネーム', with: 'test01'
        fill_in 'メール', with: 'test01@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
      }.to change { User.count }.by(1)
      expect(current_path).to eq(login_path)
    end

    it '同じメールアドレスのユーザーは新規作成できない' do
      user = create(:user)
      visit new_user_path
      expect {
        fill_in 'ユーザーネーム', with: 'test01'
        fill_in 'メール', with: user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '登録'
      }.to change { User.count }.by(0)
    end

    it '入力不足がある場合には新規作成ができない' do
      visit new_user_path
      expect {
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メール', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_on '登録'
      }.to change { User.count }.by(0)
    end
  end
end
