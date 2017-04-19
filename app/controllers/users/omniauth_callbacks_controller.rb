class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    oauth_request = request.env['omniauth.auth']
    @user = User.from_omniauth(oauth_request)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: oauth_request['provider']) if is_navigational_format?
    else
      session['devise.facebook_data'] = oauth_request
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
