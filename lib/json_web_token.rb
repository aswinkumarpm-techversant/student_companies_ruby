class JsonWebToken
  def self.encode(payload)
    expiration = (2).minutes.from_now.to_i
    payload[:exp] = expiration
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue
    nil
  end
end



require 'jwt'

class JsonWebToken
  def self.encode(payload, expiration = (2).minutes.from_now.to_i)
    payload = payload.dup
    payload[:exp] = expiration.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token,  Rails.application.secrets.secret_key_base)[0]
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end

  def self.decode_to_payload(token)
    decode(token).first.except('exp').with_indifferent_access
  end
end
