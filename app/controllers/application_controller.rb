class ApplicationController < ActionController::Base
	before_action :authorized

	def authorized
		render json: { message: 'Please log in'}, status: :unauthorized unless logged_in?
	end

	def logged_in?
		!!current_user
	end

	def current_user
		if decoded_token()
			user_id = decoded_token[0]['user_id']
			@user = User.find_by(id: user_id)
		end
	end

	def decoded_token
		if auth_header()
			JWT.decode(auth_header, 'testJWT', true, algorithm: 'HS256')
		end
	end

	def auth_header
		request.headers['Authorization']
	end

	def encode_token(payload)
		JWT.encode(payload, 'testJWT')
	end

end
