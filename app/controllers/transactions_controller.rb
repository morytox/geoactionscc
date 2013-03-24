class TransactionsController < ApplicationController
  def index
    @transactions = client.transactions.map { |t| Transaction.from_json(t) }
  end 

  def show
    @transaction = Transaction.new(client.transaction(params[:id], metadata: [:where]))
  end

  def client
    OpenBankProject::Client.new(bank: "postbank", account: "tesobe")
  end
end