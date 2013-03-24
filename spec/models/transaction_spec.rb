require 'spec_helper'

describe Transaction do
  describe ".from_json" do
    it "initializes from json" do
      transaction = Transaction.from_json(transaction_json)

      transaction_json.each do |k, v|
        transaction.send(k).should == v
      end
    end
  end
end

def transaction_json
  JSON.parse(<<-JSON, symbolize_names: true)
  {
              "uuid": "4f5745f4e4b095974c0eeead",
              "id": "The bank's id for the transaction",
              "bank_id": "some bank id",
              "view": "some view",
              "this_account": {
                  "holder": [
                       {
                          "name": "MUSIC PICTURES LIMITED",
                          "is_alias": "true/false"
                       }
                  ],
                  "number": "",
                  "kind": "",
                  "bank": {
                      "IBAN": "",
                      "national_identifier": "",
                      "name": ""
                  }
              },
              "other_account": {
                  "holder": {
                      "name": "DEUTSCHE POST AG, SSC ACC S",
                      "is_alias": "true/false"
                  },
                  "number": "",
                  "type": "",
                  "bank": {
                      "IBAN": "",
                      "national_identifier": "",
                      "name": ""
                  }
              },
              "details": {
                  "type": "cash",
                  "label": "transaction label",
                  "posted": "2012-03-07T00:00:00.001Z",
                  "completed": "2012-03-07T00:00:00.001Z",
                  "new_balance": {
                      "currency": "EUR",
                      "amount": "+ (depending on the view, this might show the balance or only +/-)"
                  },
                  "value": {
                      "currency": "EUR",
                      "amount": "-1.45"
                  }
              }
            }
  JSON
end