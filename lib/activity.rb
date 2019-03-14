class Activity
  attr_reader :name, :participants
  def initialize(name)
    @name = name
    @participants = Hash.new(0)
  end

  def add_participant(name, paid)
    @participants[name] += paid
  end

  def total_cost
    @participants.values.sum
  end

  def split
    total_cost / @participants.size
  end

  def total_owed
    @participants.transform_values{|paid| split - paid}
  end

end
