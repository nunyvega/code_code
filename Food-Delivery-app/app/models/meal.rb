class Meal
  attr_accessor :name, :price, :id

  def initialize(attr = {})
    @name = attr[:name]
    @price = attr[:price]
    @id = attr[:id]
  end
end
