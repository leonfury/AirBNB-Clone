class User < ApplicationRecord
  include Clearance::User
  validates :email, uniqueness: true
  validates :password, presence: true, on: :create
end
