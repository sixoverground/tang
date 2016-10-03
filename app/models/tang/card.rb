module Tang
  class Card < ActiveRecord::Base
    belongs_to :customer, class_name: Tang.customer_class
  end
end
