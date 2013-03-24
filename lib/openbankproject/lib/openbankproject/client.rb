module OpenBankProject
  API_ROOT = "https://demo.openbankproject.com/obp/v1.1"

  class Client
    def initialize(bank: "", account: "")
      @uri = "#{API_ROOT}/banks/#{bank}/accounts/#{account}/public"
    end

    def transactions
      flatten_transaction_roots(get_transactions[:transactions])
    end

    private

    def get_transactions
      JSON.parse(RestClient.get("#{@uri}/transactions"), symbolize_names: true)
    end

    def flatten_transaction_roots(transactions)
      transactions.map do |transaction|
        transaction[:transaction]
      end
    end
  end
end