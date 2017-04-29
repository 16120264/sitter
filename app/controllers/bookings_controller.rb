require 'my_logger'
class BookingsController < ApplicationController
  def index
    # For URL like /zones/1/booking
    # Get the zone with ID=1
    @zone = Zone.find(params[:zone_id])
    # Access all bookings for that zone
    @bookings = @zone.bookings
    @bookings = @bookings.order("date ASC")
  end

  # GET /zones/1/bookings/2
  def show
    @zone = Zone.find(params[:zone_id])
    
    # For URL like /zones/1/bookings/2
    # Get the booking for zone 2 with ID=1
    @booking = @zone.bookings.find(params[:id])
    
  end

  # Get /zones/1/bookings/new
  def new
    @zone = Zone.find(params[:zone_id])
    
    # Associate a booking object with zone 1
    @booking = @zone.bookings.build
  end

  # POST /zones/1/bookings
  def create
    @zone = Zone.find(params[:zone_id])
    
    # for URL like /zones/1/bookings
    # Populate a booking associated with the zone 1 with form data
    # Zone will ne associated with the booking
    @booking = @zone.bookings.build(booking_params)
    myBooking = @zone.bookings.new(booking_params)
    myBooking.add_on = ""
		
		# add the extra features to the new booking
		if params[:booking][:bar].to_s.length > 0 then
			myBooking.extend BarBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Bar Voucher requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:restaurant].to_s.length > 0 then
			myBooking.extend RestaurantBooking
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Restaurant Voucher requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:headset].to_s.length > 0 then
			myBooking.extend HeadsetBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Super Duper Headset requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		

		
    ## update the cost and the description details
    @booking.price = myBooking.price
    @booking.add_on = myBooking.add_on
		
    if @booking.save
      # Save the booking
      redirect_to zone_bookings_path(@zone), notice: 'Booking was successfully made.'
    else
      render :action => "new"
    end
  end

  # GET /zones/1/bookings/2/edit
  def edit
    @zone = Zone.find(params[:zone_id])
    
    # for URL like /zones/1/bookings/2/edit
    #Get booking id=2 for zone 1
    @booking = @zone.bookings.find(params[:id])
  end
  
  # PUT /zones/1/bookings/2
  def update
    @zone = Zone.find(params[:zone_id])
    @booking = Booking.find(params[:id])
    
    myBooking = @zone.bookings.new(booking_params)
    myBooking.add_on = ""
		
		# add the extra features to the new booking
		if params[:booking][:bar].to_s.length > 0 then
			myBooking.extend BarBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Bar Voucher requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:restaurant].to_s.length > 0 then
			myBooking.extend RestaurantBooking
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Restaurant Voucher requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
		if params[:booking][:headset].to_s.length > 0 then
			myBooking.extend HeadsetBooking
			# retrieve the instance/object of MyLogger class
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
      logger = MyLogger.instance
      logger.logInformation("Super Duper Headset requested")
      logger = MyLogger.instance
      logger.logInformation("------------------------------------------------")
		end
		
    # build a hash with the updated information of the booking
    updated_information = {
      "timeslot" => @booking.timeslot,
      "date" => @booking.date,
      "user_id" => @booking.user_id,
      "price" => myBooking.price,
      "add_on" => myBooking.add_on,
    }	
      if @booking.update(updated_information)
        # Save the booking successfully
        redirect_to zone_bookings_path(@zone), notice: 'Booking was successfully updated.'
      else
        render :action => "edit"
      end
  end
  
  # DELETE /zones/1/bookings/2
  def destroy
    @zone = Zone.find(params[:zone_id])
    
    @booking = Booking.find(params[:id])
    @booking.destroy
    
    respond_to do |format|
      format.html {redirect_to zone_bookings_path(@zone) }
      format.xml { head :ok }
    end
  end
  
  module BarBooking
    def price
     super + 2
    end
    def add_on
      super << 'Bar Voucher '
    end
  end
  
  module RestaurantBooking
    def price
     super + 4
    end
    def add_on
      super << 'Restaurant Voucher '
    end
  end

  module HeadsetBooking
    def price
     super + 1
    end
    def add_on
      super << 'Super Duper Headset '
    end
  end

  def booking_params
    params.require(:booking).permit(:timeslot, :date, :user_id, :price, :add_on)
  end

end
