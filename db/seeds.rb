# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Car.create{
    id: 1,
    model: 'VW Golf',
    price: 36000,
    reviews: 'fast & sleek model',
    picture: 'https://unsplash.com/photos/tWPJ3euclZY',
    name: 'Doe',
    created_at: '2021-13-08',
    updated_at: '2021-13-08',
};
Car.create{
    id: 2,
    model: 'MK7 Golf',
    price: 34000,
    reviews: 'fast & sleek model',
    picture: 'https://unsplash.com/photos/WyZh1SAPLQw',
    name: 'Doe',
    created_at: '2021-13-08',
    updated_at: '2021-13-08',
  };