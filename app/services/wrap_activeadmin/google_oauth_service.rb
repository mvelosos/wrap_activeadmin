require 'signet/oauth_2/client'

module WrapActiveadmin

  # Google OAuth Service API Integration
  class GoogleOauthService

    extend ::WrapActiveadmin::Callable

    CredentialsMissing = Class.new StandardError

    API_URL   = 'https://www.googleapis.com/auth/analytics.readonly'.freeze
    OAUTH_URL = 'https://accounts.google.com/o/oauth2'.freeze

    attr_reader :user, :error, :property

    def initialize
      raise CredentialsMissing, key_missing_msg if key_missing?
      @key         = OpenSSL::PKey::RSA.new WrapActiveadmin.google_analytics[:private_key]
      @email       = WrapActiveadmin.google_analytics[:email]
      @property_id = WrapActiveadmin.google_analytics[:tracking_code]
      @user        = user(@key, @email, API_URL)
    end

    def call
      {
        user:     @user,
        property: property
      }
    end

    def user(key, email, scope)
      auth_client  = create_auth_client(key, email, scope)
      access_token = auth_client.fetch_access_token!
      token        = create_access_token(access_token)
      Legato::User.new(token)
    rescue => error
      @error = error.message
      nil
    end

    def property
      @user.profiles.find { |x| x.web_property_id == @property_id }
    rescue
      nil
    end

    private

    def key_missing_msg
      'Please provide google_api_pkey and google_api_email'
    end

    def key_missing?
      WrapActiveadmin.google_analytics[:private_key].blank? ||
        WrapActiveadmin.google_analytics[:email].blank? ||
        WrapActiveadmin.google_analytics[:tracking_code].blank?
    end

    def create_access_token(access_token)
      OAuth2::AccessToken.new(
        oauth_client,
        access_token['access_token'],
        expires_in: access_token['expires_in']
      )
    end

    def create_auth_client(key, email, scope)
      Signet::OAuth2::Client.new(
        token_credential_uri: "#{OAUTH_URL}/token",
        audience:             "#{OAUTH_URL}/token",
        scope:                scope,
        issuer:               email,
        signing_key:          key,
        sub:                  email
      )
    end

    def oauth_client
      OAuth2::Client.new(
        '', '',
        authorize_url: "#{OAUTH_URL}/auth",
        token_url:     "#{OAUTH_URL}/token"
      )
    end

  end

end
