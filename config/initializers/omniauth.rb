Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, '208015310401-09ktaqloikb7h4vjkqmfot0h6260k9o5.apps.googleusercontent.com', 'h6Kkqrkjw2PzJqmo0BmUIePE',
	{
		scope: 'userinfo.email, userinfo.profile',
	}
end