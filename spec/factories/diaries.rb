FactoryBot.define do
  factory :diary do
    date { Date.today }
    content { '日記の内容' }
    fav
  end
end
  