require 'io/console'
require_relative 'base_view'

class EmployeesView < BaseView
  def welcome(employee)
    puts "Welcome back, #{employee.username}".blue.on_white
  end

  def ask_for_password
    puts "What's the password?"
    STDIN.noecho(&:gets).chomp
  end

  def wrong_credentials
    puts "No user found with that username / password".red
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}) #{employee.username} - #{employee.role}"
    end
  end
end
