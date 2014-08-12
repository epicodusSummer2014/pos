require 'active_record'
require './lib/product'
require './lib/sale'


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
    puts "Press '"
    puts "Press 'e' to exit"
    choice = gets.chomp
    case choice
    when 'a'
      add_product
    when 'e'
      puts "see ya"
    when 'l'
      list_products
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
  product = Product.new({:name => name, :price => price})
  product.save
  puts "'#{name}' has been added!"
end

def list_products
  puts "Here are all the products:"
  products = Product.all
  products.each { |product| puts product.name }
end

welcome
