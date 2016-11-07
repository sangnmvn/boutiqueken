class UserMailer < ActionMailer::Base
  helper :application
  default from: "Boutiqueken <boutique-ken@boutiqueken.com>"

  def welcome(user)
  	@user = user
  	subject = "Welcome to Boutiqueken!"
  	mail :to => @user.email, :subject => subject if @user
  end

  def order_confirmation(order,user)
    @order = order
    @user = user
    subject = "Confirmation of your Boutiqueken order (Order No.:#{@order.code})"
    @shipping = @order.shipping_address
    mail :to => @user.email, :subject => subject if @user
  end
end
 