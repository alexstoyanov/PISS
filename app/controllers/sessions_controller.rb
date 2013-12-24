class SessionsController < ApplicationController

  def create
    # fine the user
    user = User.authenticate(params[:email].to_s, params[:password].to_s)

    if user
      # delete stale auth tokens
      UserToken.where('user_tokens.id = ? AND user_tokens.created_at <= ?', user.id, 14.days.ago).delete_all

      # set session
      session[:user_id] = user.id

      # generate a token and set a cookie
      # a nice idea is to be able to use the token in the api as query/post parameter, but this isn't required as of now
      if params[:long_term]
        token = generate_auth_token
        UserToken.create(:user_id => user.id, :token => token)

        cookies[:auth_token] = {
          :value    => token,
          :expires  => 14.days.from_now,
        }
      end

      # drop the user object to the api client
      # perhaps we need the token too?
      render :json => {
        :status => :success,
        :user   => {
          :id             => user.id,
          :first_name     => user.first_name,
          :last_name      => user.last_name,
          :faculty_number => user.faculty_number,
          :user_type      => user.user_type
        }
      }
    else
      # tell user credentials are no good
      render :json => {
        :status => :error,
        :user   => nil,
      }, :status => :not_found
    end
  end

  def destroy
    if cookies[:auth_token]
      UserToken.where(:token => cookies[:auth_token]).delete_all
      cookies.delete :auth_token
    end

    session.delete :user_id
  end

  def current
    if current_user
      render :json => {
        :status     => :success,
        :user       => {
          :id             => current_user.id,
          :first_name     => current_user.first_name,
          :last_name      => current_user.last_name,
          :faculty_number => current_user.faculty_number,
          :user_type      => current_user.user_type
        }
      }
    else
      render :json => {
        :status => :error,
        :user   => nil,
      }, :status => :not_found
    end
  end

  protected

  def generate_auth_token
    begin
      token = SecureRandom.urlsafe_base64(32, false)
    end while UserToken.where(:token => token).exists?

    token
  end
end