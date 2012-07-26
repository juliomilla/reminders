class QuarterlyRule < Rule

  def initialize
    super("Quarterly")
  end

  def check_reminder( date, estate )
    reminder = ""
    estate.updated_due_dates.each do |due_date|
      if ( (due_date << 1)..due_date).include? date
        reminder = "#{estate.estate_code} due date #{due_date}"
      end
    end
    reminder
  end

end