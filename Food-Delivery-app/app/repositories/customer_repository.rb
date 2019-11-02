require 'csv'
require_relative '../models/customer'

class CustomerRepository
  attr_accessor :name, :address, :id

  def initialize(csv_file_path)
    @customers = []
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    load_csv if File.exist?(csv_file_path)
  end

  def add(customer)
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def find(id_number)
    @customers.each do |customer|
      return customer if customer.id == id_number.to_i
    end
  end

  def all
    @customers
  end

  def save_csv
    CSV.open(@csv_file_path, 'w', @csv_options) do |csv_object|
      csv_object << %i[id name address]
      @customers.each do |customer|
        csv_object << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, @csv_options) do |row|
      @next_id = @customers.empty? ? 1 : @customers.last.id + 1
      row[:address] = row[:address]
      row[:name] = row[:name]
      row[:id] = @next_id
      @customers << Customer.new(row)
    end
  end
end



