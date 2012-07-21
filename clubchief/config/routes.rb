Clubchief::Application.routes.draw do
  
  root :to => "home#main"
  match '/home' , :to => 'home#main'


  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :event
  match "event/new", :to => "event#new"
  post 'event/create'
  match '/event/not_attending/:id' => 'event#not_attending' ,:as => :not_attending_event
  match '/event/attending/:id' => 'event#attending' ,:as => :attending_event
  match '/event/:event_id/change_status/:attendee_id' => 'event#extern_change_attend_status'

  resources :competitions
  match '/competitions' => 'competitions#index'
  match '/competitions/apply/:competition_id' => 'competitions#apply', :as => :apply_competition
  
  resources :admin_competitions
  match '/competitions/admin' => 'admin_competitions#index'
  match '/competitions/admin/manage/:competition_id' => 'admin_competitions#show', :as => :manage_competition
  match '/competitions/admin/update' => 'admin_competitions#update'
  match '/competitions/admin/remove' => 'admin_competitions#remove'
  match '/competitions/admin/team/new/:competition_id' => 'admin_competitions#add_team', :as => :add_competition_team
  post '/admin_competitions/create_team'

  resources :admin_teams

  match '/teams/admin/:team_id' => 'admin_teams#assign', :as => :competition_team_manage
  match '/teams/admin/create_membership/:team_id/:application_id' => 'admin_teams#create_membership', :as => :create_comp_membership
  match '/teams/admin/remove_membership/:membership_id' => 'admin_teams#remove_membership', :as => :remove_comp_membership
  match '/teams/admin/remove/team/:team_id' => 'admin_teams#destroy', :as => :remove_team
  match '/teams/admin/assign_admin/:user_id/:team_id' => 'admin_teams#assign_admin', :as => :assign_team_admin
  match '/teams/admin/manage/:team_id' => 'admin_teams#manage', :as => :manage_team
  match '/teams/admin/manage/assign/:team_id/:user_id' => 'admin_teams#assign_to_team', :as => :assign_to_team
  match '/teams/admin/manage/unassign/:team_id/:user_id' => 'admin_teams#unassign_from_team', :as => :unassign_from_team

  match  '/teams/admin/rename/:id', :to => 'admin_teams#rename'

  get '/users/admin/new' => 'admin_users#new'
  post '/users/admin/create' => 'admin_users#create'
  match '/users/admin/:club_id' => 'admin_users#index', :as => :manage_club
  match '/users/admin/assign_admin/:club_id/:user_id' => 'admin_users#assign_admin', :as => :assign_admin

  
  match '/applications/admin/new/:competition_id' => 'admin_applications#new', :as => :add_users_to_competition
  match '/applications/admin/create/:competition_id/:user_id' => 'admin_applications#create' , :as => :add_user_to_competition
  
  match '/applications' => 'competition_applications#index'

  resources :clubs
  match "/clubs" ,:to => "clubs#index"
  match "/yourclubs" => "clubs#my_index", :as => "my_clubs"
  match "/clubs/destroy/:club_id" => "clubs#destroy"
  match "/clubs/apply/:id" => "clubs#apply", :as => "apply_club"
  match "/clubs/remove/:id" => "clubs#remove", :as => "remove_club"

  resources :teams

  resources :sports


  get "/notifications/show"
  match "/notifications", :to=> 'notifications#show'
  match "/notifications/new", :to => 'notifications#new'
  post "/notifications/create"
  resources :notifications
  

  resources :users
  match "/users" => "users#show"
  match "/recover" => "users#show_recover", :as => "recover_password"
  match "/users/edit_password/:id" => "users#edit_password"
  match "/users/change_password/:id" => "users#change_password"
  match '/signup', :to => 'users#new'
  match '/recover/send', :to => 'users#send_recover'
  match '/password/update', :to => 'users#update_password'
  match "/users/change_password/:id" => "users#change_password", :as => :change_password

  resources :user_verifications
  match "/user_verifications" => "user_verifications#show"

  resources :sessions
  match '/login', :to => 'sessions#new'
  match '/verify' => "sessions#create", :as => :verify_login
  match '/logout', :to => 'sessions#destroy'

  resources :admin_competitions
  match '/competitions/admin', :to => 'admin_competitions#show'
  
  match '/home/help' => 'home#help'
  resources :home


end
