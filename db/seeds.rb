# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
25.times do
  Debater.create(name: Faker::Name.name)
end

10.times do
  Tournament.create(name: Faker::Address.city, year: [2013, 2014, 2015].sample)
end

10.times do
  Team.create()
end

Team.each do |t|
  id1 = Debater.order("RANDOM()").first.id
  id2 = Debater.order("RANDOM()").first.id
  while id1 == id2
    id2 = Debater.order("RANDOM()").first.id
  end
  Pairing.create(team_id: t.id)
  Pairing.create(debater_id: id1)
  Pairing.create(team_id: t.id)
  Pairing.create(debater_id: id2)
end
