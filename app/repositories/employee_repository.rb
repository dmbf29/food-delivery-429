require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.select { |employee| employee.delivery_guy? }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # update the values before creating an instance
      # row is a hash
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
  end

end










#
