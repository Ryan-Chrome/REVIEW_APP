# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |n|
    name = Faker::Name.name
    email = "test#{n}@email.com"
    password = 'foobar'
    
    User.create!(name: name, email: email, password: password)
end

array = [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
categorys = [
    "書籍",
    "DVD・ミュージック・ゲーム",
    "家電・カメラ・AV機器",
    "パソコン・オフィス用品",
    "ホーム・キッチン・ベッド・DIY",
    "食品・飲料・お酒",
    "薬・美容",
    "ホビー",
    "衣類・装飾品",
    "スポーツ",
    "アウトドア",
    "車・バイク",
    "お店",
    "観光地",
    "その他"
]

10.times do |n|
    user = User.find_by(email: "test#{n}@email.com")
    100.times do |n|
        name = "テストレビュー#{n}"
        content = "あ" * 499
        rate = array[rand(11)]
        category = categorys[rand(15)]
        user.reviews.create(name: name, content: content, rate: rate, category: category)
    end
end