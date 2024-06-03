require 'rails_helper'

RSpec.describe "Diaries", type: :system do
  let(:user) { create(:user) }
  let!(:fav) { create(:fav, user: user) }
  let!(:diary) { create(:diary, fav: fav) }

  before do
    login_as(user)
  end

  describe 'Diary一覧' do
    it 'Diaryの一覧が表示される' do
      visit fav_diaries_path(fav)
      expect(page).to have_content diary.content
    end
  end

  describe 'Diaryの作成' do
    it '新しいDiaryを作成できる' do
      visit new_fav_diary_path(fav)
      fill_in '記録を書く', with: 'New Diary Content'
      click_button '保存'
      expect(page).to have_content 'New Diary Content' # アサーション
    end
  end

  describe 'Diary登録時内容を入れていなかったら登録できない' do
    it '新しいDiaryを作成できない' do
      visit new_fav_diary_path(fav)
      fill_in '記録を書く', with: ''
      click_button '保存'
    end
  end

  describe 'Diaryの編集' do
    it 'Diaryを編集できる' do
      visit edit_fav_diary_path(fav, diary)
      fill_in '記録を書く', with: 'Updated Diary Content'
      click_button '完了'
      expect(page).to have_content 'Updated Diary Content' # アサーション
    end
  end

  describe 'Diaryの削除' do
    it 'Diaryを削除できる' do
      visit fav_diary_path(fav, diary)
      accept_confirm do
        click_link '削除'
      end
      expect(page).not_to have_content diary.content # アサーション
    end
  end
end
