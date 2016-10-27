module Tang
  class Charge < ActiveRecord::Base
    belongs_to :invoice
  end
end
