require "csv"
require_relative "../models/customer"

class CustomersRepository

  def initialize(csv_path)
    @csv_path = csv_path
    @customers = []
    @next_id = 0
    load_csv
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    write_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def all
    @customers
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, options) do |row|
      customer = Customer.new(row)
      @customers << customer
      @next_id = customer.id
    end
    @next_id += 1
  end

  def write_csv
    CSV.open(@csv_path, "w") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
