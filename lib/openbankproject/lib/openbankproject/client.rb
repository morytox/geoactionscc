module OpenBankProject
  API_ROOT = "https://demo.openbankproject.com/obp/v1.1"

  class Client
    def initialize(bank: "postbank", account: "tesobe")
      @uri = "#{API_ROOT}/banks/#{bank}/accounts/#{account}/public"
    end

    def transactions
      flatten_transaction_roots(get_transactions[:transactions])
    end

    def transaction(id, metadata=[])
      get_transaction(id)[:transaction].tap do |transaction|
        metadata.each do |type|
          transaction[type] = get_transaction_metadata(id, type)
        end
      end
    end

    private

    def get_transaction(id)
      get_and_parse("#{@uri}/transactions/#{id}/transaction")
    end

    def get_transactions
      get_and_parse("#{@uri}/transactions")
    end

    def get_transaction_metadata(id, type)
      get_and_parse("#{@uri}/transactions/#{id}/metadata/#{type}")
    end

    def get_and_parse(url)
      JSON.parse(RestClient.get(url), symbolize_names: true)
    end

    def flatten_transaction_roots(transactions)
      transactions.map do |transaction|
        transaction[:transaction]
      end
    end
  end
end