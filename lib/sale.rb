class Sale < ActiveRecord::Base
  has_many :carts
  has_many :products, through: :carts
  belongs_to :cashier

  def cost_of_sale
    total_cost = 0

    Cart.all.each do |cart|
      if self.id == cart.sale_id
          total_cost += cart.product.price * cart.quantity
      end
    end
    total_cost
  end

  def reciept
    products = []
    Cart.all.each do |cart|
      if self.id == cart.sale_id
        products << cart.product.name
        products << cart.product.price
      end
    end
    products
  end

  def self.total_by_date(begin_date, end_date)
    all_sales = self.where(:created_at => begin_date..end_date)
    total_sales = 0
    all_sales.each do |sale|
      total_sales +=sale.cost_of_sale.to_i
    end
    total_sales
  end

  def self.number_of_sales_by_cashier(begin_date, end_date, cashier_id)
    all_sales = self.where(:created_at => begin_date..end_date)
    total_sales = 0
    all_sales.each do |sale|
      if cashier_id == sale.cashier_id
        total_sales += 1
      end
    end
    total_sales
  end
end
