require 'active_record'
require 'rspec'
require 'product'
require 'sale'
require 'cashier'
require 'cart'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |employee| employee.destroy }
    Sale.all.each { |division| division.destroy }
    Cart.all.each { |cart| cart.destroy }
    Cashier.all.each { |cashier| cashier.destroy }
  end
end
