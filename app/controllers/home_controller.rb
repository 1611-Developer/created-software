class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @public_posts = Post.where(is_public: true).includes(:user).order(created_at: :desc).limit(12)
  end
end
