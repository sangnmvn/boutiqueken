class UserMailer < ActionMailer::Base
  default "Boutiqueken <boutique-ken@boutiqueken.com>"

  def welcome(user)
  	@user = user
  	subject = "Welcome to Boutiqueken!"
  	mail :to => @user.email, :subject => subject if @user
  end
end
 