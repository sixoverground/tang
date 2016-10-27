module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    has_one :charge
  end
end
