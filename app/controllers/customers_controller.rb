require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # customers = ask the repo for all the customers
    customers = @customer_repository.all
    # give them to the view to display
    @customers_view.display(customers)
  end

  def add
    # ask the user for a name
    name = @customers_view.ask_for('name')
    # ask the user for a address
    address = @customers_view.ask_for('address')
    # create an instance
    customer = Customer.new(
      name: name,
      address: address
    )
    # give it to the repository
    @customer_repository.create(customer)
  end
end
