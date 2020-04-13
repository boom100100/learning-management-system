Rails.application.config.middleware.use OmniAuth::Builder do
   provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET'] #{#, scope: 'email', info_fields: 'email', auth_type: 'rerequest'
  #   callback_path: '/teachers/auth/github/callback'
  # }
  # configure do |config|
  #   config.path_prefix = '/teachers/auth'
  # end
  # #on_failure { |env| AuthenticationsController.action(:failure).call(env) }
  #
  # on_failure do |env|
  #   #we need to setup env
  #   if env['omniauth.params'].present
  #     env["devise.mapping"] = Teachers.mappings[:teachers]
  #   end
  #   Teachers::OmniauthCallbacksController.action(:failure).call(env)
  # end
  #
end
