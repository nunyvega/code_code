require_relative '../models/customer'
require_relative "../repositories/customer_repository"
require_relative '../views/view'

class CustomersController
  attr_accessor :customer_repository
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = View.new
  end

  def list
    list = @customer_repository.all
    @view.print_customers(list)
  end

  def add
    customer_array = @view.add_new_customer
    customer = Customer.new(name: customer_array[0], address: customer_array[1])
    @customer_repository.add(customer)
  end

  def find_by_id
    id = @view.search_id
    customer = @customer_repository.find(id)
    @view.print_one("customer: #{customer.name}, address: #{customer.address}")
  end
end

