require 'google/apis/identitytoolkit_v3'

module FirebaseAdminAuth
  class Client
    SCOPE = 'https://www.googleapis.com/auth/identitytoolkit'.freeze
    MAX_TIMES = 3.freeze

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

      attempt_times = 0
      begin
        attempt_times += 1
        @result = @service.signup_new_user(request_signup)
      rescue => e
        if attempt_times <= MAX_TIMES
          retry
        else
          puts e
          raise
        end
      ensure
        puts 'finish'
      end

      @result.local_id
    end
  end
end










