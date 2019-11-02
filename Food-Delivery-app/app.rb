require_relative '../01-Food-Delivery/app/repositories/meal_repository'
require_relative '../01-Food-Delivery/app/controllers/meals_controller'
require_relative '../01-Food-Delivery/app/repositories/customer_repository'
require_relative '../01-Food-Delivery/app/controllers/customers_controller'
require_relative '../01-Food-Delivery/app/repositories/employee_repository'
require_relative '../01-Food-Delivery/app/controllers/employees_controller'
require_relative '../01-Food-Delivery/app/controllers/orders_controller'
require_relative '../01-Food-Delivery/app/repositories/order_repository'
require_relative 'router'

meals_csv_file = File.join(__dir__, 'meals.csv')
mealrepository = MealRepository.new(meals_csv_file)
mealscontroller = MealsController.new(mealrepository)

customers_csv_file = File.join(__dir__, 'customers.csv')
customerrepository = CustomerRepository.new(customers_csv_file)
customerscontroller = CustomersController.new(customerrepository)

employees_csv_file = File.join(__dir__, 'employees.csv')
employeerepository = EmployeeRepository.new(employees_csv_file)
employeescontroller = EmployeesController.new(employeerepository)

orders_csv_file = File.join(__dir__, 'orders.csv')
orderrepository = OrderRepository.new(orders_csv_file, mealrepository, employeerepository, customerrepository)
orderscontroller = OrdersController.new(mealrepository, employeerepository, customerrepository, orderrepository)

router = Router.new(mealscontroller, customerscontroller, employeescontroller, orderscontroller)

# Start the app
router.run
