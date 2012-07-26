class TwiceAYearRule < Rule

  def initialize
    super("Twice a year")
  end

  def check_reminder( date, estate )
    reminder = ""
    estate.updated_due_dates.each do |due_date|
      if ( (due_date << 2)..due_date).include? date
        reminder = "#{estate.estate_code} due date #{due_date}"
      end
    end
    reminder
  end

end