require 'google/apis/identitytoolkit_v3'

module FirebaseAdminAuth
  class Client
    SCOPE = 'https://www.googleapis.com/auth/identitytoolkit'

    def initialize(service_account_json_key)
      @service = Google::Apis::IdentitytoolkitV3::IdentityToolkitService.new
      @service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open(service_account_json_key),
        scope: SCOPE
      )
    end

    def get_firebase_uid(email, password)
      request_signup = Google::Apis::IdentitytoolkitV3::SignupNewUserRequest.new(
        email: email,
        password: password,
        email_verified: true
      )

      @service.signup_new_user(request_signup)
      result.local_id
    end
  end
end










