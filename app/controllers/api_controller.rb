class ApiController < ApplicationController
  before_action :authorize_request


  private 


  rescue_from Exception do |exception|
    case exception
    when ActiveRecord::RecordNotFound
        render json: {message: "data not found"}, status: 404
    else
      raise exception
    end
  end


  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode(header, Rails.application.secrets.secret_key_base)
      @current_user = User.find(@decoded.first["user_id"].to_i)
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { message: e.message }, status: :unauthorized
    end
  end
end