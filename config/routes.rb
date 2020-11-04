Rails.application.routes.draw do
	post "/login", to: "users#login"
	post "/register", to: "users#register"

	resources :users
	resources :user_infos
	resources :boards do
		collection do
			get '/private', to: 'boards#privateBoard'
			get '/public', to: 'boards#publicBoard'
		end
	end
	resources :columns
	resources :cards

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
