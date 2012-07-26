require 'spec_helper'

describe Reminder, '#on' do

  before(:all) do
    @estates = []
    @estates << Estate.new("0066S", "Quarterly", "1st Feb, 3rd May, 1st Aug, 5th Nov")
    @estates << Estate.new("0123S", "Quarterly", "28th Feb, 31st May, 31st Aug, 30th Nov")
    @estates << Estate.new("0250S", "Twice a year", "23rd Jan, 22nd Jun")

    @reminder_rules = []
    @reminder_rules << QuarterlyRule.new
    @reminder_rules << TwiceAYearRule.new
  end

  it "should return reminders for 1st Jan 2009" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("1st Jan 2009", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("1st Feb 2009")}"
    reminders[1].should eq "0250S due date #{Date.parse("23rd Jan 2009")}"
    reminders.length.should eq 2
  end

  it "should return reminders for 1st Feb 2009" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("1st Feb 2009", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("1st Feb 2009")}"
    reminders[1].should eq "0123S due date #{Date.parse("28th Feb 2009")}"
    reminders.length.should eq 2
  end

  it "should return reminders for 2nd Feb 1979" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("2nd Feb 1979", @estates)
    reminders[0].should eq "0123S due date #{Date.parse("28th Feb 1979")}"
    reminders.length.should eq 1
  end

  it "should not return reminders for 15th Mar 1999" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("15th Mar 1999", @estates)
    reminders.length.should eq 0
  end

  it "should return reminders for 21st Apr 2013" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("21st Apr 2013", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("3rd May 2013")}"
    reminders.length.should eq 1
  end

  it "should return reminders for 22nd Apr 2017" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("22nd Apr 2017", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("3rd May 2017")}"
    reminders[1].should eq "0250S due date #{Date.parse("22nd Jun 2017")}"
    reminders.length.should eq 2
  end

  it "should return reminders for 29th Apr 2000" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("29th Apr 2000", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("3rd May 2000")}"
    reminders[1].should eq "0250S due date #{Date.parse("22nd Jun 2000")}"
    reminders.length.should eq 2
  end

  it "should return reminders for 30th Apr 2002" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("30th Apr 2002", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("3rd May 2002")}"
    reminders[1].should eq "0123S due date #{Date.parse("31st May 2002")}"
    reminders[2].should eq "0250S due date #{Date.parse("22nd Jun 2002")}"
    reminders.length.should eq 3
  end

  it "should return reminders for 29th Oct 2011" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("29th Oct 2011 ", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("5th Nov 2011")}"
    reminders.length.should eq 1
  end

  it "should return reminders for 30th Oct 2011" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("30th Oct 2011", @estates)
    reminders[0].should eq "0066S due date #{Date.parse("5th Nov 2011")}"
    reminders[1].should eq "0123S due date #{Date.parse("30th Nov 2011")}"
    reminders.length.should eq 2
  end

  it "should return reminders for 24th Dec 2006" do
    @reminder = Reminder.new(@reminder_rules)
    reminders = @reminder.on("24th Dec 2006", @estates)
    reminders[0].should eq "0250S due date #{Date.parse("23rd Jan 2007")}"
    reminders.length.should eq 1
  end


end