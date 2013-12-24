class UsersController < ApplicationController
  
  def create
    user = User.new(params[:user])

    if user.save
      render :json => {
        :status     => :success,
        :user       => {
          :id             => user.id,
          :first_name     => user.first_name,
          :last_name      => user.last_name,
          :faculty_number => user.faculty_number,
          :user_type      => user.user_type
        }
      }
    else
      render :json => {
        :status     => :error,
        :errors     => user.errors,
      }, :status => :unprocessable_entity
    end
  end

  def update
    if current_user.save(params[:user])
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
        :status     => :error,
        :errors     => current_user.errors,
      }, :status => :unprocessable_entity
    end
  rescue
    render :json => {
      :status     => :error,
      :error      => :not_logged_in,
    }, :status => :unprocessable_entity
  end
end