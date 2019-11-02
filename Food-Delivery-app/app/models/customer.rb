class Customer
  attr_accessor :name, :address, :id

  def initialize(attr = {})
    @name = attr[:name]
    @address = attr[:address]
    @id = attr[:id]
  end
end

