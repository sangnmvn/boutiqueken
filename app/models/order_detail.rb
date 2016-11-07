class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_price_detail
  belongs_to :product

  before_save :cal_subtotal
  after_save :cal_order_total
  def cal_subtotal
    self.sub_total = self.price * self.quantity
  end
  
  def show_price
    self.currency.to_s + " " + self.price.to_s
  end

  def show_sub_total
    [self.currency,self.sub_total.to_s].join(" ")
  end

  def cal_order_total
    order = self.order
    order.total +=self.sub_total
    order.save
  end

end
