require 'rails_helper'

RSpec.describe "Favs", type: :system do
  let(:user) { create(:user) }
  let!(:fav) { create(:fav, user: user) }

  before do
    login_as(user)
  end

  describe 'Fav一覧' do
    it 'Favの一覧が表示される' do
      visit favs_path
      expect(page).to have_content fav.name
    end
  end

  describe 'Favの作成' do
    it '新しいFavを作成できる' do
      visit new_fav_path
      fill_in '名前', with: 'New Fav'
      click_button '登録'
      expect(page).to have_content 'New Fav'
    end
  end

  describe 'Favの編集' do
    it 'Favを編集できる' do
      visit edit_fav_path(fav)
      fill_in '名前', with: 'Updated Fav'
      click_button '更新'
      expect(page).to have_content 'Updated Fav' 
    end
  end

  describe 'Favの削除' do
    it 'Favを削除できる' do
      visit fav_path(fav)
      accept_confirm do
        click_link '削除'
      end
      expect(page).not_to have_content fav.name
    end
  end
end
