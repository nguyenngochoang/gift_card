class Api::V1::BaseController < ActionController::API
  before_action :authenticate_user_from_api_key!

  private

  def authenticate_user_from_api_key!
    api_key = request.headers['Authorization']
    user = User.find_by(api_key: api_key)

    if user
      sign_in user, store: false
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
