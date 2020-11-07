Rails.application.routes.draw do
	resources :users do
		resources :user_infos
	end

	post '/login', to: 'users#login'
	post '/register', to: 'users#register'

	resources :boards do
		collection do
			get '/private', to: 'boards#privateBoard'
			get '/public', to: 'boards#publicBoard'
		end
		resources :columns do
			resources :cards
		end
	end	

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
