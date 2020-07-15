require 'io/console'
require_relative 'base_view'

class EmployeesView < BaseView
  def welcome(employee)
    puts "Welcome back, #{employee.username}"
  end

  def ask_for_password
    puts "What's the password?"
    STDIN.noecho(&:gets).chomp
  end
end
