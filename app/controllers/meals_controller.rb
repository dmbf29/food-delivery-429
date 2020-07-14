require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # meals = ask the repo for all the meals
    meals = @meal_repository.all
    # give them to the view to display
    @meals_view.display(meals)
  end

  def add
    # ask the user for a name
    name = @meals_view.ask_for('name')
    # ask the user for a price
    price = @meals_view.ask_for('price').to_i
    # create an instance
    meal = Meal.new(
      name: name,
      price: price
    )
    # give it to the repository
    @meal_repository.create(meal)
  end
end
