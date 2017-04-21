class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:index, :login, :register, :create]

  def index
  	redirect_to '/register'
  end

  def login
  end

  def register
  end

  def create
  	if Lender.find_by_email(params[:email])
  		@user = Lender.find_by_email(params[:email])
  		session[:identity] = "lender"
  	else
  		Borrower.find_by_email(params[:email])
  		@user = Borrower.find_by_email(params[:email])
  		session[:identity] = "borrower"
  	end

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if session[:identity] == "lender"
      	redirect_to "/lenders/#{@user.id}"
      elsif session[:identity] == "borrower"
      	redirect_to "/borrowers/#{@user.id}"
      else
      	redirect_to :back
      end
    else 
      flash[:errors] = ["Invalid Combination"]
      redirect_to :back
    end
  end


end
