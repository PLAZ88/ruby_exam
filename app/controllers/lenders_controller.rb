class LendersController < ApplicationController

  skip_before_action :require_login, only: [:create]
  before_action :require_correct_user, only: [:show]

  def current_lender
    Lender.find(session[:user_id]) if session[:user_id]
  end

  def show
  	@lender = Lender.find(params[:id])
  	@all_borrowers = Borrower.all
  	@lended = Transaction.where(lender_id: session[:user_id])
    @total = Transaction.where(borrower_id: "?").sum(:money_lent)
  end

  def create
	  	@lender = Lender.new(lender_params)
	    if @lender.save
	      session[:user_id] = @lender.id
	      redirect_to "/lenders/#{@lender.id}"
	    else
	      flash[:errors] = @lender.errors.full_messages
	      redirect_to :back
      end
  end

  def destroy
    @lender = Lender.find(params[:id])
    reset_session
    redirect_to :root
  end

  # def update
  	# @lender = Lender.find(params[:id])
  	# @borrower = Borrower.find(params[:id]).amount_needed
  	# @total = @lender.money
   #  if @total - @borrower < 0
   #    redirect_to "/lenders/#{@lender.id}"
   #  else
   #    @total -= @lender.money
   #    @transaction = Transaction.new(transaction_params)
   #    if @transaction.save
   #    	redirect_to "/lenders/#{@lender.id}"
   #    else
   #    	redirect_to "/lenders/#{@lender.id}"
   #    end
   #  end
  # end

  private

    def require_correct_user
      if current_lender != Lender.find(params[:id])
        redirect_to '/login'
      end
    end

    def lender_params
      params.require(:lender).permit(:first_name, :last_name, :email, :money, :password)
    end

end
