require 'active_record'
require './lib/product'
require './lib/sale'
require './lib/cashier'
require './lib/cart'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the POS!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a product"
    puts "Press 'l' to list all products"
    puts "Press 'c' to login a cashier"
    puts "Press 's' to begin a transaction"
    puts "Press 't' to view total sales"
    puts "Press 'q' to view transaction count by cashier"
    puts "Press 'e' to exit"
    choice = gets.chomp
    case choice
    when 'a'
      add_product
    when 'e'
      puts "see ya"
    when 'l'
      list_products
    when 'c'
      add_cashier
    when 's'
      begin_transaction
    when 't'
      view_transactions
    when 'q'
      sales_by_cashier
    else
      puts "not a valid option"
    end
  end
end

def add_product
  puts "What is the name of the product"
  name = gets.chomp
  puts "What is the product price?"
  price = gets.chomp
  product = Product.create({:name => name, :price => price})
  product.save
  puts "'#{name}' has been added!"
end

def list_products
  puts "Here are all the products:"
  products = Product.all
  products.each { |product| puts product.name }
end

def add_cashier
  puts "What is the cashier's name?"
  input_name = gets.chomp
  Cashier.find_or_create_by(:name => input_name)
  puts "'#{input_name}' is in the database"
end

def begin_transaction
  Cashier.all.each {|cashier| puts cashier.name}
  puts "Input the cashier's name"
  cashier_input = gets.chomp
  cashier= Cashier.find_or_create_by(:name => cashier_input)
  sale = Sale.create({:cashier_id => cashier.id})
  add_product_to_transaction(sale.id)
end

def add_product_to_transaction(sale_id_from_begin)
  Product.all.each {|product| puts product.name}
  puts "What product is the customer purchasing?"
  product_input = gets.chomp
  product = Product.find_by(:name => product_input)
  puts "How many '#{product_input}' are being purchased?"
  quantity_input = gets.chomp
  cart = Cart.create({:product_id => product.id, :quantity => quantity_input, :sale_id => sale_id_from_begin})
  puts "would you like to add another item?"
  input = gets.chomp
  if input == 'y'
    add_product_to_transaction(sale_id_from_begin)
  elsif input == 'n'
    view_total_cost(sale_id_from_begin)
  end
end

def view_total_cost(sale_id)
  sale = Sale.find_by(:id => sale_id)
  total = sale.cost_of_sale
  puts "TRANSACTION #{sale_id}"
  puts "Your total cost is $#{total}."
  puts "Would the customer like to see a breakout of the purchase?"
  input = gets.chomp
  if input == 'y'
    view_reciept(sale_id)
  elsif input == 'n'
    menu
  end
end

def view_reciept(sale_id)
  sale = Sale.find_by(:id => sale_id)
  reciept = sale.reciept
  reciept.each { |reciept_item| puts reciept_item }
end

def view_transactions
  puts "What is the beginning date for the transaction search?"
  begin_date = gets.chomp
  puts "What is the end date for the transaction search?"
  end_date = gets.chomp
  total = Sale.total_by_date(begin_date, end_date)
  puts total
end

def sales_by_cashier
  Cashier.all.each {|cashier| puts cashier.name}
  puts "What cashier would you like to explore?"
  cashier = Cashier.find_by(:name => gets.chomp)
  puts "What is the begin date?"
  begin_date = gets.chomp
  puts "What is the end date?"
  end_date = gets.chomp
  sales = Sale.number_of_sales_by_cashier(begin_date, end_date, cashier.id)
  puts sales
end

welcome
