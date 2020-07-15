class OrdersView < BaseView
  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1}) #{order.meal.name} - #{order.customer.name}
         (#{order.customer.address}) -\n EMPLOYEE: #{order.employee.username}"
      end
    else
      puts "No orders yet ☹️"
    end
  end
end
