require 'my_logger'
class BookingsController < ApplicationController
  def index
    # For URL like /users/1/booking
    # Get the user with ID=1
    @user = User.find(params[:user_id])
    # Access all bookings for that user
    @bookings = @user.bookings
    @bookings = @bookings.order("date ASC")
  end

  # GET /users/1/bookings/2
  def show
    @user = User.find(params[:user_id])
    
    # For URL like /users/1/bookings/2
    # Get the booking for user 2 with ID=1
    @booking = @user.bookings.find(params[:id])
    
  end

  # Get /users/1/bookings/new
  def new
    @user = User.find(params[:user_id])
    
    # Associate a booking object with user 1
    @booking = @user.bookings.build
  end

  # POST /users/1/bookings
  def create
    @user = User.find(params[:user_id])
    
    # for URL like /users/1/bookings
    # Populate a booking associated with the user 1 with form data
    # User will be associated with the booking
    @booking = @user.bookings.build(booking_params)
    myBooking = @user.bookings.new(booking_params)
    myBooking.add_on = ""
		
		# add the extra features to the new booking
		if params[:booking][:h1xe].to_s.length > 0 then
			myBooking.extend H1xeBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("1 early hour requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:h2xe].to_s.length > 0 then
			myBooking.extend H2xeBooking
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("2 early hours requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:h1xl].to_s.length > 0 then
			myBooking.extend H1xlBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("1 late hour requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
    ## update the cost and the description details
    @booking.price = myBooking.price
    @booking.add_on = myBooking.add_on
		
    if @booking.save
      # Save the booking
      redirect_to user_bookings_path(@user), notice: 'Booking was successfully made.'
    else
      render :action => "new"
    end
  end

  # GET /users/1/bookings/2/edit
  def edit

    @user = User.find(params[:user_id])
    
    # for URL like /users/1/bookings/2/edit
    #Get booking id=2 for user 1
    
    @booking = Booking.find(params[:id])
    
  end
  
  # PUT /users/1/bookings/2
  def update
    
    @user = User.find(params[:user_id])
    
    # @user = current_user.id
    @booking = Booking.find(params[:id])
    
    myBooking = @user.bookings.new(booking_params)
    myBooking.add_on = ""
		
		# add the extra features to the new booking
		if params[:booking][:h1xe].to_s.length > 0 then
			myBooking.extend H1xeBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("1 early hour requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:h2xe].to_s.length > 0 then
			myBooking.extend H2xeBooking
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("2 early hours requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:h1xl].to_s.length > 0 then
			myBooking.extend H1xlBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("1 late hour requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
    # build a hash with the updated information of the booking
    updated_information = {
      "timeslot" => @booking.timeslot,
      "date" => @booking.date,
      "zone_id" => @booking.user_id,
      "user_id" => @booking.user_id,
      "price" => myBooking.price,
      "add_on" => myBooking.add_on,
    }	
      if @booking.update(updated_information)
        # Save the booking successfully
        redirect_to user_bookings_path(@user), notice: 'Booking was successfully updated.'
      else
        render :action => "edit"
      end
  end
  
  # DELETE /users/1/bookings/2
  def destroy
    @user = current_user.id
    
    @booking = Booking.find(params[:id])
    @booking.destroy
    
    respond_to do |format|
      format.html {redirect_to page_path('show_all') }
      format.xml { head :ok }
    end
  end
  
  def update_confirmed
    @booking = Booking.find(params[:id])
    @booking.update_attributes(:confirmed => true)
    redirect_to page_path('show_all'), notice: 'Booking was successfully confirmed.'
  end
  
  def update_reviewed
    @booking = Booking.find(params[:id])
    @booking.update_attributes(:reviewed => true)
    redirect_to page_path('show_all'), notice: 'Booking was successfully confirmed.'
  end  
  
  module H1xeBooking
    def price
     super + 15
    end
    def add_on
      super << ' :1 early hour requested'
    end
  end
  
  module H2xeBooking
    def price
     super + 30
    end
    def add_on
      super << ' :2 early hours requested '
    end
  end

  module H1xlBooking
    def price
     super + 20
    end
    def add_on
      super << ' :1 late hour requested'
    end
  end

  def booking_params
    params.require(:booking).permit(:timeslot, :date, :zone_id, :user_id, :price, :add_on)
  end

end
