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

  describe "GET #show" do
    let(:client) { mock }
    let(:transaction) { {} }

    before do
      OpenBankProject::Client.should_receive(:new).with(bank: "postbank", account: "tesobe")
        .and_return(client)

      client.should_receive(:transaction).with("this is the id", metadata: [:where]).and_return(transaction)
    end

    it "assigns the transaction" do
      get :show, id: "this is the id"

      assigns(:transaction).should be_a(Transaction)
    end
  end
end