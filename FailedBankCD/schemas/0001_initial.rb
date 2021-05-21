
schema "0001 initial" do
  entity "FailedBankInfo" do
    string    :name,        optional: false
    string    :city,        optional: false
    string    :state,       optional: false
    has_one   :details, inverse: "FailedBankDetails.info"
  end

  entity "FailedBankDetails" do
    integer16  :zip,        optional: false
    datetime   :close_date, optional: false
    datetime   :update_date, optional: false
    has_one :info, inverse: "FailedBankInfo.details"
  end

end
