require 'spec_helper'

describe TransactionsController do
  describe "GET #index" do
    let(:transactions) { [{}, {}] }

    before do
      OpenBankProject::Client.should_receive(:new).with(bank: "postbank", account: "tesobe")
        .and_return(mock(transactions: transactions))
    end

    it "assigns the transactions" do
      get :index
      
      transactions = assigns(:transactions)
      transactions.should have(2).items
      transactions.each { |t| t.should be_a(Transaction) }
    end
  end
end