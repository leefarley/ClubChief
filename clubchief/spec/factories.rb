Factory.define :user do |user|
  user.first_name            "foo"
  user.last_name             "bar"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :membership do |membership|
  membership.association :user
  membership.association :club
end


Factory.define :sport do |sport|
  sport.sport_name          "Ice Hockey"
end

Factory.define :club do |club|
  club.name                 "foo bar"
  club.description          "foo bar is a club, join,please"
  club.association          :sport
end