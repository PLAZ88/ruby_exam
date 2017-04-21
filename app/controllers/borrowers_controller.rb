class BorrowersController < ApplicationController

  skip_before_action :require_login, only: [:create]
  before_action :require_correct_user, only: [:show]

  def current_borrower
    Borrower.find(session[:user_id]) if session[:user_id]
  end

  def show
  	@borrower = Borrower.find(session[:user_id])
  	@lended = Transaction.where(borrower_id: session[:user_id])

  end

  def create
	  	@borrower = Borrower.new(borrower_params)
	    if @borrower.save
	      session[:user_id] = @borrower.id
	      redirect_to "/borrowers/#{@borrower.id}"
	    else
	      flash[:errors] = @borrower.errors.full_messages
	      redirect_to :back
	    end
  end

  # def update
  # end

  def destroy
  	@borrower = Borrower.find(params[:id])
  	reset_session
    redirect_to :root
  end

  private

    def require_correct_user
      if current_borrower != Borrower.find(params[:id])
        redirect_to '/login'
      end
    end

    def borrower_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :loan_for, :description, :amount_needed, :password)
    end

end
