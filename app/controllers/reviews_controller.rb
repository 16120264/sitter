class ReviewsController < ApplicationController
  def index
    # For URL like /bookings/1/review
    # Get the booking with ID=1
    
    @booking = Booking.find(params[:booking_id])
    
    # Access all reviews for that booking
    @reviews = Review.find_by_sql ["select a.* from reviews a where a.client = ?", @booking.zone_id]
  end

  # GET /bookings/1/reviews/2
  def show
    # For URL like /bookings/1/review
    # Get the booking with ID=1

    @booking = Booking.find(params[:booking_id])

    # Access all reviews for that booking
    @reviews = Review.find_by_sql ["select a.* from reviews a where a.client = ?", @booking.zone_id]
  end

  # Get /bookings/1/reviews/new
  def new
    
    @booking = Booking.find(params[:format])
    
    # Associate a review object with booking 1
    @review = @booking.reviews.build
  end

  # POST /bookings/1/reviews
  def create
    
    @user = current_user
    
    @booking = Booking.find(params[:booking_id])
    
    
    # for URL like /bookings/1/reviews
    # Populate a review associated with the booking 1 with form data
    # Booking will ne associated with the review
    @review = @booking.reviews.build(params.require(:review).permit(:details, :client, :sitter))
    if @review.save
      # Save the review
      redirect_to booking_review_path(@booking, @review)
    else
      render :action => "new"
    end
  end

  # GET /bookings/1/reviews/2/edit
  def edit
    
    @booking = Booking.find(params[:booking_id])
    
    # for URL like /bookings/1/reviews/2/edit
    #Get review id=2 for booking 1
    @review = Review.find(params[:id])
  end
  
  # PUT /bookings/1/reviews/2
  def update
    
    @booking = Booking.find(params[:booking_id])
    @review = Review.find(params[:id])
    if @review.update_attributes(params.require(:review).permit(:details))
      # Save the review successfully
      redirect_to booking_review_url(@booking, @review)
    else
      render :action => "edit"
    end
  end
  
  # DELETE /bookings/1/reviews/2
  def destroy

    @booking = Booking.find(params[:booking_id])
    
    @review = Review.find(params[:id])
    @review.destroy
    
    respond_to do |format|
      format.html {redirect_to booking_review_path(@booking, @review) }
      format.xml { head :ok }
    end
  end
  
  #def destroy
  #  @booking.destroy
  #  respond_to do |format|
  #    format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
  #    format.json { head :no_content }
  # end
  #end  

  
end



