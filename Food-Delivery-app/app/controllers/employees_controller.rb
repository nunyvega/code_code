require_relative '../models/employee'
require_relative "../repositories/employee_repository"
require_relative '../views/view'

class EmployeesController
  attr_accessor :employee_repository
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = View.new
  end

  def list
    list = @employee_repository.all
    @view.print_employees(list)
  end

  def list_delivery_guys
    list = @employee_repository.all_delivery_guys
    @view.print_employees(list)
  end

  def find_by_id
    id = @view.search_id
    user = @employee_repository.find(id)
    @view.print_one("username: #{user.username}, role: #{user.role}")
  end

  def find_by_username
    username = @view.search_username
    user = @employee_repository.find_by_username(username)
    @view.print_one("username: #{user.username}, role: #{user.role}")
  end

  def check_password(username, password)
    user = @employee_repository.find_by_username(username)
    if user == false
      return false
    elsif password == user.password
      return true
    else
      return false
    end
  end

  def find_role(username)
    employee = @employee_repository.find_by_username(username)
    return employee.role
  end
end

