require_relative '../models/order'
require_relative "../repositories/order_repository"
require_relative '../views/view'

class OrdersController
  attr_accessor :order_repository
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @order_repository = order_repository
    @view = View.new
  end

  def list
    list = @order_repository.all
    @view.print_orders(list)
  end

  def add
    array = @view.add_new_order
    order = Order.new(@order_repository.ids_to_elem(meal_id: array[0], customer_id: array[1], employee_id: array[2]))
    @order_repository.add(order)
  end

  def find_by_id
    id = @view.search_id
    order = @order_repository.find(id)
    @view.print_one("meal:#{order.meal}-empl:#{order.employee}-customer:#{order.customer}-deliv?:#{order.delivered?}")
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.print_orders(orders)
  end

  def mark_as_delivered(employee)
    id = @view.search_id
    order = @order_repository.find(id)
    order.deliver!
    @order_repository.save_csv
  end

  def list_my_orders(employee)
    # check if it's a hash or the name in a string
    employee = employee.username if employee.class == Employee
    orders = @order_repository.find_my_orders(employee)
    orders.each do |order|
      @view.print_orders2("#{order.customer.name} #{order.meal.name}")
    end
  end
end


