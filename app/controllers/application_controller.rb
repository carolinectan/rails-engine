class ApplicationController < ActionController::API
  def not_found_404
    render json: {}, status: :not_found
  end
end
