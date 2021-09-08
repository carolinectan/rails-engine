class ApplicationController < ActionController::API
  def not_found_404
    render json: {}, status: :not_found
  end

#   {
#   "error_object": {
#     "error_message": "No members found with the last name: tu",
#     "status": "NOT FOUND",
#     "code": 404
#   }
# }
end
