class Transaction < Struct.new(:uuid, :id, :this_account, :other_account, :details, :view, :bank_id)
  def self.from_json(json)
    new.tap do |transaction|
      json.each do |k, v|
        transaction.send("#{k}=", v)
      end
    end
  end
end