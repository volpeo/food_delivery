class Order
  attr_accessor :id, :customer, :employee, :meal
  attr_reader :date, :delivered

  def initialize(attributes)
    @id = attributes[:id].to_i
    @date = attributes[:date] || Time.now
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @meal = attributes[:meal]
    @delivered = (attributes[:delivered] == "true")
  end

  def mark_as_delivered!
    @delivered = true
  end

  def delivered?
    @delivered
  end
end