# frozen_string_literal: true
require 'firebase_admin_auth/client'

RSpec.describe FirebaseAdminAuth do
  it "has a version number" do
    expect(FirebaseAdminAuth::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end

  describe "any" do
    let(:service_account_json_key) { "./config/credentials/test-json-key" }
    let(:email) { "test@test.com"}
    let(:password) { "testpassword" }

    def create_user
      client = FirebaseAdminAuth::Client.new(service_account_json_key)
      client.get_firebase_uid(email, password)
    end

    before do
      allow_any_instance_of(FirebaseAdminAuth::Client).to receive(:initialize).with(anything)
      allow_any_instance_of(FirebaseAdminAuth::Client).to receive(:get_firebase_uid).with(anything, anything).and_return("testfirebaseuid")
    end

    it "success create user" do
      expect(create_user).to match("testfirebaseuid")
    end
  end
end
