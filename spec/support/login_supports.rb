module LoginSupports
  def login_as(user)
    visit login_path
    fill_in 'メール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
  