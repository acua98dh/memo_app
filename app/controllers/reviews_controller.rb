class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

#  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
#  def index
#    @reviews = Review.all
#  end

  # GET /reviews/1
  # GET /reviews/1.json
#  def show
#  end

  # GET /reviews/new
#  def new
#    @review = Review.new
#  end

  # GET /reviews/1/edit
  def edit
    @current_tags = @review.tags.name
  end

  # POST /reviews
  # POST /reviews.json

  def create
    @review = current_user.reviews.build(review_params)
    tag_list = params[:tag_name].split(",")#
    if @review.save
      flash[:success] = "Review created!"
      redirect_to root_url
      @review.save_reviews(tag_list)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end
#    @review = Review.new(review_params)
#    respond_to do |format|
#      if @review.save
#        format.html { redirect_to @review, notice: 'Review was successfully created.' }
#        redirect_to root_url
#        format.json { render :show, status: :created, location: @review }
#      else
#        format.html { render :new }
#        format.json { render json: @review.errors, status: :unprocessable_entity }
#    @review.reviews.build(review_params)
#    @review.review_tags.tag.build(tag_name)


  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update(review_params)
      tag_list = params[:tag_name].split(",")#
      @review.save_reviews(tag_list)#
      redirect_to :root
#        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
#        format.json { render :root, status: :ok, location: @review }
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    redirect_to root_url
#    respond_to do |format|
#      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
#      format.json { head :no_content }
#    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:name, :rating, :review, :freq, tag_attributes: [:id,:name])#
    end
    
    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
    
    def review_update_params
      params.require(:review).permit(:name, :rating, :review, :freq)
    end
    
    def correct_user
      @user = User.find(@review.user_id)
      redirect_to(root_url) unless @user == current_user
    end

end
