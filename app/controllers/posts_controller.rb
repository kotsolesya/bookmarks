class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :edit, :destroy]


  def index
    #@posts ||= Post.order('created_at DESC').page params[:page]
    @post = Post.new
    @posts = Post.all
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC").page params[:page]
    else
      @posts = Post.all.order('created_at DESC').page params[:page]
    end
  end

  def show
  end

  def new
  #  @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: posts_url }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: posts_url}
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url, :id_user, :screenshot_url)
  end
end
