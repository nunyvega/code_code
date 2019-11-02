require 'csv'
require_relative '../models/order'
require_relative 'employee_repository'
require_relative 'customer_repository'
require_relative 'meal_repository'


class OrderRepository
  attr_accessor :meal, :id, :employee, :customer

  def initialize(csv_file_path, meal_repository, employee_repository, customer_repository)
    @orders = []
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    load_csv if File.exist?(csv_file_path)
  end

  def find(id_number)
    @orders.each do |order|
      return order if order.id == id_number.to_i
    end
  end

  def all
    @orders
  end

  def find_by_employee(employee)
    orders_employee = []
    @orders.each do |order|
      orders_employee << order if order.employee == employee
    end
    return orders_employee
  end

  def find_my_orders(employee)
    orders_employee = []
    @orders.each do |order|
      orders_employee << order if order.employee.username == employee
    end
    return orders_employee
  end

  def undelivered_orders
    orders = []
    @orders.each do |order|
      orders << order if order.delivered? == false
    end
    return orders
  end

  def add(order)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def load_csv
    CSV.foreach(@csv_file_path, @csv_options) do |row|
      @next_id = @orders.empty? ? 1 : @orders.last.id + 1
      hash1 = ids_to_elem(row)
      @orders << Order.new(hash1)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'w', @csv_options) do |csv_object|
      csv_object << %i[id delivered meal_id employee_id customer_id]
      @orders.each do |order|
        csv_object << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end

  def ids_to_elem(row)
    hash1 = {}
    hash1[:meal] = @meal_repository.find(row[:meal_id])
    hash1[:employee] = @employee_repository.find(row[:employee_id])
    hash1[:customer] = @customer_repository.find(row[:customer_id])
    hash1[:id] = @next_id
    hash1[:delivered] = row[:delivered]
    row[:id] = @next_id
    return hash1
  end
end


