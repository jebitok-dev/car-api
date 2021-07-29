class JsonWebToken
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i

        JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
        body = JWT.decode(token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new body
    rescue JWT::DecodeError => e

        raise ExceptionHandler::InvalidToken, e.message
    end
end

module ExceptionHandler
    extend ActiveSupport::Concern

    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end

    include do 
        rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
        rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
        rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
        rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

        rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({message: e.message}, :not_found)  
        end
    end

    private

    def four_twenty_two(e)
        json_response({message: e.message}, :unprocessable_entity)
    end

    def unauthorized_request(e)
        json_response({message: e.message}, :unauthorized)
    end
end
