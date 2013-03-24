require 'spec_helper'

describe OpenBankProject::Client do
  subject { OpenBankProject::Client.new(bank: "mybank", account: "myaccount")}

  context "#transactions" do
    before do
      RestClient.should_receive(:get)
        .any_number_of_times
        .with(OpenBankProject::API_ROOT + "/banks/mybank/accounts/myaccount/public/transactions")
        .and_return(transactions_json)
    end

    it "returns all transactions" do
      subject.transactions.should have(2).items
    end

    it "has the right data" do
      subject.transactions.first[:uuid].should == "4f5745f4e4b095974c0eeead"
      subject.transactions.first[:details][:type].should == "cash"

      subject.transactions.last[:uuid].should == "123asdf"
      subject.transactions.last[:details][:type].should == "credit card"
    end
  end
end

def transactions_json
  <<-JSON
 {
  "transactions": [
      {
        "transaction": {
            "uuid": "4f5745f4e4b095974c0eeead",
            "id": "The bank's id for the transaction",
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
      }, 
      {
          "transaction": {
              "uuid": "123asdf",
              "id": "The bank's id for the transaction",
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
                  "type": "credit card",
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
      }
  ]
}
  JSON
end
  