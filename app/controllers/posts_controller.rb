class PostsController < ApplicationController

  require 'RMagick'
  include Magick


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # APU for RMagick
    # http://www.imagemagick.org/RMagick/doc/usage.html


    img = ImageList.new('public/bg.jpeg')
    txt = Draw.new

    qs = DateTime.now().to_s
    text1 = "Spree Endes in: "

 

    img.annotate(txt, 0,0,-200,100, text1) {
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 30
      txt.stroke = '#000000'
      txt.fill = "#ffffff"
      txt.font_weight = Magick::BoldWeight
    }

    img.annotate(txt, 0,0,150,100, qs) {
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 30
      txt.stroke = '#000000'
      txt.fill = "#ffffff"
      txt.font_weight = Magick::BoldWeight
    }
    img.format = 'jpeg'
    send_data img.to_blob, :stream => 'false', :filename => 'public/test.jpg', :type => 'image/jpeg', :disposition => 'inline'



    # @post = Post.find(params[:id])

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @post }
    # end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
