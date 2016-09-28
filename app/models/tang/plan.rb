module Tang
  class Plan < ActiveRecord::Base
    has_paper_trail
    validates :stripe_id, uniqueness: true
  end
end
