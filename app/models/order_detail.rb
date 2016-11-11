class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_price_detail
  belongs_to :product

  before_save :cal_subtotal
  after_save :cal_order_total
  def cal_subtotal
    self.sub_total = self.price * self.quantity
    self.price_by_currency = MoneyExchange.exchange(price,self.currency_by_user)
    self.subtotal_by_currency = MoneyExchange.exchange(self.sub_total,self.currency_by_user)
  end
  
  def show_price
    self.currency_by_user.to_s + " " + self.price_by_currency.to_s
  end

  def show_sub_total
    [self.currency_by_user,self.subtotal_by_currency.to_s].join(" ")
  end

  def cal_order_total
    order = self.order
    order.total +=self.sub_total
    order.total_by_currency = MoneyExchange.exchange(order.total,order.currency_by_user)
    order.save
  end

end
