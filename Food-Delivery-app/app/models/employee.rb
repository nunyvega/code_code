class Employee
  attr_accessor :username, :id, :password, :role

  def initialize(attr = {})
    @id = attr[:id]
    @username = attr[:username]
    @password = attr[:password]
    @role = attr[:role]
  end

  def manager?
    @role == "manager"
  end

  def delivery_guy?
    @role == "delivery_guy"
  end
end
