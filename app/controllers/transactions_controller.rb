class TransactionsController < ApplicationController
  def index
    client = OpenBankProject::Client.new(bank: "postbank", account: "tesobe")
    @transactions = client.transactions.map { |t| Transaction.from_json(t) }
  end 

  def show
    
  end
end