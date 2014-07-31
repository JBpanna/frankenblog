class PostsController < ApplicationController
  before_action :write_before, only: [:practice]
  before_action :set_post, only: [:show, :edit, :single, :practice, :update, :destroy, :experiment]
  after_action :write_after, only: [:practice]
  around_action :write_around, only: [:practice]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def play
    @posts = Post.all
  end

 def test
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def persistence
    x=Post.all.find_by(title: 'John')
    x.destroy
    head :ok
  end

  def fakerMaker
    100.times do |post|
      title = "#{Faker::Name.first_name}"
      body = "#{Faker::Name.first_name}"
      Post.create(
      :title => title,
      :body => body,
      :starred => 0
      )
    end
    head :ok
  end

  def fakerSaver
    x=Post.create(
      title: 'Final',
      body: 'Fantasy',
      starred: 1
      )
    p x

    y=Post.new(
      title: 'Cindy'
      )
    y.save 
    y.title = 'Cinderella'
    y.save
    p y

    v=Post.all.find_by(title: 'Cinderella')
    v.update_attributes(
      title: 'Candy Corn'
      )
    p v

    Post.update_all "starred='true'"

    del=Post.find_by(title: 'Final')
    del.destroy
    
    p Post.all

    wh=Post.where("title=? OR body=?", params[:post], 'Fantasy')
    p wh

    lk=Post.where(:title => "title like J%")
    lk.each{|lk| p lk}
    

    head :ok
  end

  def practice
    p "hello"
  end

  def query
    x=Post.all.limit(4)
      p x
    head :ok
  end

  def single
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def write_before
      p "before"
    end

    def write_after
      p "after"
    end

    def write_around
      p "one"
      begin
        yield
      end
      p "two"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :starred)
    end
end
