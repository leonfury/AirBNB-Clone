class User < ApplicationRecord
    include Clearance::User
    paginates_per 15
    validates :email, uniqueness: true
    validates :password, presence: true, on: :create
    has_many :listings

    ##roles
    enum role: [:member, :moderator, :superadmin]

    #carrierwave
    mount_uploader :photo, PhotoUploader

    #########################################################################
    # For google sign in
    has_many :authentications, dependent: :destroy
    # ^ has many :authentications is useful if using more than one authorization provider
    # v creates a user object base on information given by provider
    def self.create_with_auth_and_hash(authentication, auth_hash)
        user = self.create!(
        # left side assignment refers to our user database
        # right side assignment is from google profile
        first_name: auth_hash["info"]["first_name"],
        last_name: auth_hash["info"]["last_name"],
        email: auth_hash["info"]["email"],
        # setup above is for user to key in their own Google psw to log in
        # we do not need to store user's password
        # however, due to Clearance, our database schema, column encrypted_password doesn't allow null column
        # so assign random password to it :
        # users sign in through google anyway
        password: SecureRandom.hex(10)
        )
        user.authentications << authentication
        return user
    end
    
    # grab google to access google for user data
    def google_token
        x = self.authentications.find_by(provider: 'google_oauth2')
        return x.token unless x.nil?
    end
    #########################################################################
end
