class Order
  attr_accessor :id, :meal, :employee, :customer, :delivered

  def initialize(attr = {})
    @id = attr[:id]
    @delivered = attr[:delivered].to_s.downcase == "true" || false
    @meal = attr[:meal]
    @employee = attr[:employee]
    @customer = attr[:customer]
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
