require 'active_record'
require 'rspec'
require 'product'
require 'sale'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each { |employee| employee.destroy }
    Sale.all.each { |division| division.destroy }
    #Project.all.each { |project| project.destroy }
  end
end
