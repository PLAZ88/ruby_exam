class TransactionsController < ApplicationController

  def create

  	@transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to :back
    else
      flash[:errors] = @transaction.errors.full_messages
      redirect_to :back
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:lender_id, :borrower_id, :money_lent)
    end

end
