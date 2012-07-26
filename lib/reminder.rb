class Reminder

  def initialize( reminder_rules )
    @reminder_rules = reminder_rules
  end

  def on( date, estates )
    date = Date.parse(date)
    reminders = []
    estates.each do |estate|
      estate.update_due_dates(date)
      rule = @reminder_rules.detect { |r| r.description == estate.service_charge_period }
      result = rule.check_reminder(date, estate) if rule
      reminders << result unless result == ""
    end
    reminders
  end

end