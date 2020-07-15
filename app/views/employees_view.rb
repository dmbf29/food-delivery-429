require_relative 'base_view'

class EmployeesView < BaseView
  def welcome(employee)
    puts "Welcome back, #{employee.username}"
  end
end
