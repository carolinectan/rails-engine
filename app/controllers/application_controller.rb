class ApplicationController < ActionController::API
  def not_found_404
    render json: {}, status: :not_found # 404
  end
end
