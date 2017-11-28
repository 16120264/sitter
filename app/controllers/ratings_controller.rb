class RatingsController < ApplicationController
  def index
    # For URL like /bookings/1/rating
    # Get the booking with ID=1
    
    @booking = Booking.find(params[:booking_id])
    
    # Access all ratings for that booking
    @ratings = Rating.find_by_sql ["select a.* from ratings a where a.sitter = ?", @booking.user_id]
  end

  # GET /bookings/1/ratings/2
  def show
    # For URL like /bookings/1/rating
    # Get the booking with ID=1

    @booking = Booking.find(params[:booking_id])

    # Access all ratings for that booking
    @ratings = Rating.find_by_sql ["select a.* from ratings a where a.sitter = ?", @booking.user_id]
  end

  # Get /bookings/1/ratings/new
  def new
    
    @booking = Booking.find(params[:format])
    
    # Associate a rating object with booking 1
    @rating = @booking.ratings.build
  end

  # POST /bookings/1/ratings
  def create
    
    @user = current_user
    
    @booking = Booking.find(params[:booking_id])
    
    
    # for URL like /bookings/1/ratings
    # Populate a rating associated with the booking 1 with form data
    # Booking will ne associated with the rating
    @rating = @booking.ratings.build(params.require(:rating).permit(:stars, :client, :sitter))
    if @rating.save
      # Save the rating
      redirect_to booking_rating_path(@booking, @rating)
    else
      render :action => "new"
    end
  end

  # GET /bookings/1/ratings/2/edit
  def edit
    
    @booking = Booking.find(params[:booking_id])
    
    # for URL like /bookings/1/ratings/2/edit
    #Get rating id=2 for booking 1
    @rating = Rating.find(params[:id])
  end
  
  # PUT /bookings/1/ratings/2
  def update
    
    @booking = Booking.find(params[:booking_id])
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(params.require(:rating).permit(:details))
      # Save the rating successfully
      redirect_to booking_rating_url(@booking, @rating)
    else
      render :action => "edit"
    end
  end
  
  # DELETE /bookings/1/ratings/2
  def destroy

    @booking = Booking.find(params[:booking_id])
    
    @rating = Rating.find(params[:id])
    @rating.destroy
    
    respond_to do |format|
      format.html {redirect_to booking_rating_path(@booking, @rating) }
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



