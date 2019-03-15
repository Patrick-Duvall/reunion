require "pry"

class Reunion
  attr_reader :name, :activities
  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.map{|activity|activity.total_cost}.sum
  end

  def participants
    @activities.map{|activity|activity.participants.keys}.flatten
  end

  def owed_per_activity
    @activities.map(&:total_owed)
  end


  def breakout
    pay_sheet = owed_per_activity.reduce{ |activity, next_activity| activity.merge(next_activity){|person, paid_1,paid_2| paid_1 + paid_2 }}
    pay_sheet
  end

  def summary

    breakout.map{|person, owes| "#{person}: #{owes}\n"}.join.chomp

  end

  def detailed_breakout
    breakout = {}
    participants.each{|participant| breakout[participant] = []}
    binding.pry

  end

end
