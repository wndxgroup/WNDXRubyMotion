class FailedBankStore
  include CDQ

  def self.shared
    # Our store is a singleton object.
    @shared ||= FailedBankStore.new
  end

  def banks
    @banks ||= FailedBankInfo.all
  end

  def add_bank
    # Yield a blank, newly created bank entity, then save the model.
    yield FailedBankInfo.create, FailedBankDetails.create
    save
  end

  def remove_bank(bank)
    # Delete the given entity, then save the model.
    bank.destroy
    save
  end

  # The purpose of the load, is to pull in data from an external source, and load it into your CoreData store. It can
  # be invoked from the REPL

  private

  def initialize
    cdq.setup
  end

  def save
    cdq.save
    @banks = nil
  end
end