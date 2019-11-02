class Router
  def initialize(meals_controller, customers_controller, employees_controller, orders_controller)
    @customers_controller = customers_controller
    @meals_controller = meals_controller
    @employees_controller = employees_controller
    @orders_controller = orders_controller
    @running = true
    @logged_in = false
    @logged_user = ""
    @logged_user_role = ""
  end

  def run
    puts "Welcome to the Restaurant!"
    puts "           --           "
    while @running
      login while @logged_in == false
      list_messages
      action = gets.chomp.to_i
      print `clear`
      choose_route_action(action)
    end
  end

  def choose_route_action(action)
    if @logged_user_role == "delivery_guy"
      route_action_employee(action)
    elsif @logged_user_role == "manager"
      route_action_manager(action)
    end
  end

  def login
    puts ">username?"
    username = gets.chomp
    puts ">password?"
    password = gets.chomp
    check_result = @employees_controller.check_password(username, password)
    password_message(check_result, username)
  end

  def list_messages
    if @logged_user_role == "delivery_guy"
      display_tasks_employee
    elsif @logged_user_role == "manager"
      display_tasks_manager
    end
  end

  def password_message(check_result, username)
    if check_result == true
      puts "welcome #{username.capitalize}!"
      @logged_user = username
      @logged_in = true
      @logged_user_role = @employees_controller.find_role(username)
    else
      puts "Wrong credentials... Try again!"
    end
  end

  private

  def route_action_manager(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 0 then stop
    else puts "Please press your option"
    end
  end

  def route_action_employee(action)
    case action
    when 1 then @orders_controller.list_my_orders(@logged_user)
    when 2 then @orders_controller.mark_as_delivered(@logged_user)
    when 0 then stop
    else puts "Please press your option"
    end
  end

  def stop
    @running = false
  end

  def display_tasks_manager
    puts "What do you want to do next?"
    puts "1 - Create a new meal"
    puts "2 - List all meals"
    puts "3 - Create a new customer"
    puts "4 - List all customers"
    puts "5 - List undelivered orders"
    puts "6 - Add new order"
    puts "0 - Stop and exit the program"
  end

  def display_tasks_employee
    puts "What do you want to do next?"
    puts "1 - List my orders"
    puts "2 - Mark order as delivered"
    puts "0 - Stop and exit the program"
  end
end



