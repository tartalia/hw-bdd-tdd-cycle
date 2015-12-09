factory :movie do |m|
  m.title { Faker::Name.title }
  m.rating { Faker::Name.rating }
  m.director { Faker::Name.director }
  m.release_date { Faker::Name.release_date }
end
