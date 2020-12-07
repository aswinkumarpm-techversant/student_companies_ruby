class Api::V1::HomeController < ApiController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  def index
    puts current_user.email
    render json: { user: current_user.email, list: [1, 2, 3] }

  end
end
