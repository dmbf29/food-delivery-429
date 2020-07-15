require 'csv'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  undef_method :create

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end

  def build_element(row)
    row[:id] = row[:id].to_i
    Employee.new(row)
  end
end










#
