class View
  def print_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name} : #{meal.price}"
    end
  end

  def add_new_meal
    content = []
    puts "what's the name of the meal?'"
    print ">"
    content[0] = gets.chomp
    puts "what's the price of the meal?'"
    print ">"
    content[1] = gets.chomp
    return content
  end

  def print_customers(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name} : #{customer.address}"
    end
  end

  def add_new_customer
    content = []
    print "what's the name of the customer?\n>"
    content[0] = gets.chomp
    print "what's the address of the customer?\n>"
    content[1] = gets.chomp
    return content
  end

  def print_employees(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username} : #{employee.role}"
    end
  end

  def search_id
    print "What's the id number?\n>"
    gets.chomp
  end

  def search_username
    print "What's the username?\n>"
    gets.chomp
  end

  def print_one(info)
    puts info.to_s
  end

  def search_orders_employee
    print "What's the name of the employee?\n>"
    gets.chomp
  end

  def print_orders(orders)
    orders.each do |ord|
      puts "#{ord.meal.name},emp:#{ord.employee.username},#{ord.customer.name}"
    end
  end

  def print_orders2(string)
    puts string
  end

  def add_new_order
    print "what's the meal id?\n>"
    meal_id = gets.chomp
    print "what's the customer id?\n>"
    customer_id = gets.chomp
    print "what's the employee id?\n>"
    employee_id = gets.chomp
    return [meal_id, customer_id, employee_id]
  end
end



