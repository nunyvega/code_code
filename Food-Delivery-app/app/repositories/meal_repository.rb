require 'csv'
require_relative '../models/meal'

class MealRepository
  attr_accessor :name, :price, :id

  def initialize(csv_file_path)
    @meals = []
    @csv_file_path = csv_file_path
    @csv_options = { headers: :first_row, header_converters: :symbol }
    load_csv if File.exist?(csv_file_path)
  end

  def add(meal)
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def find(id_number)
    @meals.each do |meal|
      return meal if meal.id == id_number.to_i
    end
  end

  def all
    @meals
  end

  def save_csv
    CSV.open(@csv_file_path, 'w', @csv_options) do |csv_object|
      csv_object << %i[id name price]
      @meals.each do |meal|
        csv_object << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, @csv_options) do |row|
      @next_id = @meals.empty? ? 1 : @meals.last.id + 1
      row[:price] = row[:price].to_i
      row[:name] = row[:name]
      row[:id] = @next_id
      @meals << Meal.new(row)
    end
  end
end



