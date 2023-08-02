class Api::AuthController < ApiController
    skip_before_action :authorize_request, only: [:login]

    def login
        user = User.find_by_email params[:email]

        return render json: {message: "user not found"}, status: 404 unless user
        if user.valid_password? params[:password]
            payload = {user_id: user.id, exp: 24.hours.from_now.to_i}
            token = JWT.encode( payload, Rails.application.secrets.secret_key_base)
            data = user.to_objects
            data[:token] = token
            return render json: {message: 'login success', data: data}
        else
            return render json: {message: 'Invalid credentials provided'}, status: 400
        end
    end
end
