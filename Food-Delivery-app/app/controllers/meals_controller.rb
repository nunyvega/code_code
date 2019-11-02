require_relative '../models/meal'
require_relative "../repositories/meal_repository"
require_relative '../views/view'

class MealsController
  attr_accessor :meal_repository
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = View.new
  end

  def list
    list = @meal_repository.all
    @view.print_meals(list)
  end

  def add
    meal_array = @view.add_new_meal
    meal = Meal.new(name: meal_array[0], price: meal_array[1].to_i)
    @meal_repository.add(meal)
  end

  def find_by_id
    id = @view.search_id
    meal = @meal_repository.find(id)
    @view.print_one("meal: #{meal.name}, price: #{meal.price}")
  end
end

