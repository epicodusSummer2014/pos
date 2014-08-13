require 'spec_helper'

describe 'Sale' do
  it 'adds products and returns the total price' do
    cashier = Cashier.create({:name => 'Peggy'})
    sale = Sale.create({:cashier_id => cashier.id})
    product = Product.create({:name => 'banana', :price => 2})
    cart = Cart.create({:product_id => product.id, :quantity => 3, :sale_id => sale.id})
    cart = Cart.create({:product_id => product.id, :quantity => 5, :sale_id => sale.id})
    expect(sale.cost_of_sale).to eq 16
  end

  it 'returns the product names' do
    cashier = Cashier.create({:name => 'Peggy'})
    sale = Sale.create({:cashier_id => cashier.id})
    product = Product.create({:name => 'banana', :price => 2})
    product2 = Product.create({:name => 'grapes', :price => 5})
    cart = Cart.create({:product_id => product.id, :quantity => 3, :sale_id => sale.id})
    cart = Cart.create({:product_id => product2.id, :quantity => 5, :sale_id => sale.id})
    expect(sale.reciept).to eq [product.name, product.price, product2.name, product2.price]
  end

  it 'returns total by date range' do
    cashier = Cashier.create({:name => 'Peggy'})
    sale = Sale.create({:cashier_id => cashier.id})
    product = Product.create({:name => 'banana', :price => 2})
    product2 = Product.create({:name => 'grapes', :price => 5})
    cart = Cart.create({:product_id => product.id, :quantity => 3, :sale_id => sale.id})
    cart = Cart.create({:product_id => product2.id, :quantity => 5, :sale_id => sale.id})
    expect(Sale.total_by_date('2014-08-12', '2014-08-14')).to eq 31
  end

  it 'returns all sales by cashier for a date range' do
    cashier = Cashier.create({:name => 'Peggy'})
    cashier2 = Cashier.create({:name => 'Petunia'})
    sale = Sale.create({:cashier_id => cashier.id})
    sale2 = Sale.create({:cashier_id => cashier.id})
    sale3 = Sale.create({:cashier_id => cashier2.id})
    product = Product.create({:name => 'banana', :price => 2})
    product2 = Product.create({:name => 'grapes', :price => 5})
    cart = Cart.create({:product_id => product.id, :quantity => 3, :sale_id => sale.id})
    cart = Cart.create({:product_id => product2.id, :quantity => 5, :sale_id => sale2.id})
    cart = Cart.create({:product_id => product.id, :quantity => 3, :sale_id => sale3.id})
    expect(Sale.number_of_sales_by_cashier('2014-08-12', '2014-08-14', cashier.id)).to eq 2
  end
end

