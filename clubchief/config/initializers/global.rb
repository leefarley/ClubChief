
#Global constant values for entire application use
if Rails.env.development?
  BASE_URL = "localhost:3000"
else
  BASE_URL = "clubchief.heroku.com"
end
TIME_OUT = 60 # minutes