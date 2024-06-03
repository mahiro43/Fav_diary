FactoryBot.define do
    factory :fav do
      name { "Example Fav" }
      birthday { Date.today }
      user
    end
  end
  