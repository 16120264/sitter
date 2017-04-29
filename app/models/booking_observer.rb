#saved in the file app/models/booking_observer.rb
require 'my_logger'
class BookingObserver < ActiveRecord::Observer
    def after_update(record)
        # use the MyLogger instance method to retrieve the single instance/object of the class
        @logger = MyLogger.instance
        # use the logger to log/record a message about the updated booking
        @logger.logInformation("###############Observer Demo:#")
        @logger.logInformation("+++ BookingObserver: Booking has been updated. Now #{record.price}")
        @logger.logInformation("##############################")
    end
end