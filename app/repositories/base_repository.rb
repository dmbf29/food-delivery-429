class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path) # check the meal_repo
  end

  def all
    @elements
  end

  def create(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # update the values before creating an instance
      # row is a hash
      @elements << build_element(row)
    end
    @next_id = @elements.last.id + 1 if @elements.any?
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << @elements.first.class.headers # Customer.headers / Meal.headers
      @elements.each do |element| # instance
        csv << element.build_row
      end
    end
  end
end
