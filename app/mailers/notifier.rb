class Notifier < ActionMailer::Base
  default from: "nithyapreethi2210@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.new_user_created.subject
  #
  def new_user_created(user)
    @user = user
    mail :to =>'nithyaah@railsfactory.org', :subject => 'New user registered'
  end
end



 #def order_received(product)
  #  @product = product
   # name =@product.name
    ##mail :to => "arun.n@railsfactory.org", :subject => 'Pragmatic Store product Confirmation'
    #ActionMailer::Base.mail(:from => "arunkumarit02@gmial.com", :to => "arun.n@railsfactory.org", :subject => "Adding new product", :body => "the product #{name} is added into the list").deliver
  #end
