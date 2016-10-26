module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    belongs_to :charge
  end
end
