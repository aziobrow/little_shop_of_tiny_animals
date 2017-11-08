# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Category.create!([{
  name: "Technology"
},{
  name: "Home Repair"
}])

User.create!([{
  username: "user",
  password: "1234",
  email: "aziobrow@gmail.com",
  name: "Aurora Doe",
  address: "123 Fake St. Denver, CO 80226"
},{
  username: "admin",
  password: "1234",
  email: "anna@gmail.com",
  role: :admin,
  name: "Anna Doe",
  address: "456 Fake St. Denver, CO 80202"
}])

Item.create!([{
  title: "Build a Website",
  description: "I'll make you a cool website!",
  category: Category.first,
  unit_price: 1099,
  image_url: "http://www.makeawebsiteguru.com/wp-content/uploads/2015/04/ways-to-build-a-website.png"
},{
  title: "Plumbing",
  description: "I'll unclog your sink!",
  category: Category.last,
  unit_price: 15000,
  image_url: "https://www.homedepot.com/hdus/en_US/DTCCOMNEW/fetch/Category_Pages/Kitchen/Sinks/bar-prep-sink-400x400-2.png",
  active: false,
  units: 0
}])

Order.create!([{
  user: User.default.first,
  original_address: User.default.first.address,
  original_purchaser: User.default.first.name
},{
  user: User.default.first,
  original_address: User.default.first.address,
  original_purchaser: User.default.first.name
}])

OrderItem.create!([{
  order: Order.first,
  item: Item.first,
  quantity: 2,
  original_unit_price: Item.first.unit_price,
  units: Item.first.units
},{
  order: Order.first,
  item: Item.last,
  quantity: 1,
  original_unit_price: Item.last.unit_price,
  units: Item.last.units
},{
  order: Order.last,
  item: Item.first,
  quantity: 3,
  original_unit_price: Item.first.unit_price,
  units: Item.first.units
}])
