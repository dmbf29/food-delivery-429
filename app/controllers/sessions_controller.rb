require_relative '../views/employees_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @employees_view = EmployeesView.new
  end

  def sign_in
    # ask user for username
    username = @employees_view.ask_for('username')
    # ask user for password
    password = @employees_view.ask_for_password
    # try to find the user by username
    employee = @employee_repository.find_by_username(username)
    # if we find it && the password is right
    if employee && employee.password == password
      @employees_view.welcome(employee)
      employee
    else
      sign_in
    end
  end
end
