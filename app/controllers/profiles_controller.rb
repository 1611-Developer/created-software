class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def show
    @user = User.find_by!(user_name: params[:user_name])
    @posts = @user.posts.where(is_public: true).order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  private

    def user_not_found
      render "shared/not_found", status: :not_found
    end
end
