class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :show_by_slug]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    if current_user
      @posts = current_user.posts
    else
      @posts = Post.where(is_public: true)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    unless @post.is_public || (current_user && current_user == @post.user)
      redirect_to root_path, alert: "This is private."
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Project was successfully destroyed'
  end

def explore
  query = params[:query].to_s.strip
  if query.present?
    @posts = Post.where(is_public: true)
                 .where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
                 .includes(:user)
                 .order(created_at: :desc)
  else
    @posts = Post.where(is_public: true)
                 .includes(:user)
                 .order(created_at: :desc)
  end

  respond_to do |format|
    format.html
    format.turbo_stream
  end
end


  def show_by_slug
    user = User.find_by!(user_name: params[:user_name])
    @post = user.posts.find_by!(slug: params[:slug])
    unless @post.is_public || (current_user && current_user == @post.user)
      redirect_to root_path, alert: "This project is private."
      return
    end
    render :show
  rescue ActiveRecord::RecordNotFound
    if Rails.env.production?
      render 'shared/not_found', status: :not_found
    else
      raise
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      #@post = current_user.posts.find(params[:id])
      @post = Post.find(params[:id])
    end
    
    def authorize_user!
      redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :repo_link, :demo_link, :screenshot, :is_public)
    end
end
