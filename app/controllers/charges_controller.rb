class ChargesController < ApplicationController


  def new
  end

  def create
  # Amount in cents
  @amount = (Post.find(params[:post_id]).price*100).round
  @application_fee = @amount*0.10.round
  @email = params[:stripeEmail]
  @user_stripe = (Post.find(params[:post_id]).user.stripeid)
=begin
  customer = Stripe::Customer.create(
    :email => @email,
    :card  => params[:stripeToken]
  )
=end

charge = Stripe::Charge.create({
    #:customer    => customer.id,
    :amount      => @amount.round,
    :application_fee => @application_fee,
    :description => 'Payment to Studiocracy user',
    :currency    => 'usd',
    :destination => @user_stripe,
    :source => params[:stripeToken]
    }
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
  end
end