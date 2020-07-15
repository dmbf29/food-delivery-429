require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def add
    meal = set_meal
    customer = set_customer
    employee = set_employee
    # create an intance of order
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give to repo
    @order_repository.create(order)
  end

  def list_my_undelivered_orders(current_user)
    list_my_orders(current_user)
  end

  def mark_as_delivered(current_user)
    # need undelivered orders for that user
    # list them
    orders = list_my_orders(current_user)
    # ask DG for which order index
    index = @employees_view.ask_for('number').to_i - 1
    # we need an instance
    orders = @order_repository.my_undelivered_orders(current_user)
    order = orders[index]
    # send it to the repository
    @order_repository.mark_as_delivered(order)
  end

  private

  def set_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meals[index]
  end

  def set_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customers[index]
  end

  def set_employee
    employees = @employee_repository.all_delivery_guys
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    employees[index]
  end

  def list_my_orders(current_user)
    orders = @order_repository.my_undelivered_orders(current_user)
    @orders_view.display(orders)
    orders # the user doesnt see this at all
  end
end
