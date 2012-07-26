require 'date'

class Estate

  def initialize( estate_code, service_charge_period, due_dates )
    @estate_code = estate_code
    @service_charge_period = service_charge_period
    @due_dates = due_dates.split(',').map{ |d| Date.parse(d) }
  end

  attr_reader :estate_code, :service_charge_period, :updated_due_dates

  # updates all the due dates to a later date depending on the current date
  def update_due_dates( current_date )
    @updated_due_dates = []
    @due_dates.each do |due_date|
       new_date = Date.new(current_date.year, due_date.month, due_date.day)
       # if the due date is older than the current date we add one year
       if new_date < current_date
         new_date = Date.new(current_date.year + 1, due_date.month, due_date.day)
       end
       @updated_due_dates << new_date
    end
  end

end