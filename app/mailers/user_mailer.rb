class UserMailer < ActionMailer::Base
  helper :application
  #default from: "Boutiqueken <boutique-ken@boutiqueken.com>"
  default from: "Boutiqueken <care@boutiqueken.com>"

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
    mail :to => @order.email,:cc=>[@user.email], :subject => subject if @user
  end

  def contact_us(topic, name_txt, email, comments)
  #def contact_us
    subject = topic
    @email_address = email
    @name = name_txt
    @comments = comments
    mail :to => "care@boutiqueken.com", :subject => subject
  end
end
 