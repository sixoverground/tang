module Tang
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    # Set the current user to track versions.
    before_action :set_paper_trail_whodunnit

    # Include all engine helpers.
    helper Tang::Engine.helpers
  end
end
