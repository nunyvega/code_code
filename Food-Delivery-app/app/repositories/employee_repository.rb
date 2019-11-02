require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  attr_accessor :username, :id, :password, :role

  def initialize(csv_file_path)
    @employees = []
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    load_csv if File.exist?(csv_file_path)
  end

  def find(id_number)
    @employees.each do |employee|
      return employee if employee.id == id_number.to_i
    end
  end

  def all
    @employees
  end

  def all_delivery_guys
    array = []
    @employees.each do |employee|
      array << employee if employee.role == "delivery_guy"
    end
    return array
  end

  def find_by_username(username)
    @employees.each do |employee|
      return employee if employee.username == username
    end
    return false
  end

  def load_csv
    CSV.foreach(@csv_file_path, @csv_options) do |row|
      @next_id = @employees.empty? ? 1 : @employees.last.id + 1
      row[:id] = @next_id
      @employees << Employee.new(row)
    end
  end
end



