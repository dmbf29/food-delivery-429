class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    puts "Welcome to the Fig Restaurant!".red
    puts "           --           "

    while @running
      puts "Please sign in...".green
      @employee = @sessions_controller.sign_in
      while @employee
        if @employee.manager?
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          display_delivery_tasks
          action = gets.chomp.to_i
          print `clear`
          route_delivery_action(action)
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 8 then @employee = false
    when 9 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def route_delivery_action(action)
    case action
    when 1 then @orders_controller.list_my_undelivered_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 8 then @employee = false
    when 9 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def stop
    puts "Goodbye 👋".green.blink
    @employee = false
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?".yellow
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - List undelivered orders"
    puts "6 - Add a new order"
    puts "8 - Sign out"
    puts "9 - Stop and exit the program"
  end

  def display_delivery_tasks
    puts ""
    puts "What do you want to do next?".yellow
    puts "1 - List my undelivered orders"
    puts "2 - Mark an order as delivered"
    puts "8 - Sign out"
    puts "9 - Stop and exit the program"
  end
end
