require 'digest/sha1'
class User < ApplicationRecord
  has_merit


  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  before_create :crypter_pass

  def self.authenticate username, password
    user = find_by(username: username)
    return nil if user and user.password != User.crypter(password)
    user
  end

  private
    def crypter_pass
      self.password = User.crypter(password)
    end

    def self.crypter pass
      Digest::MD5.hexdigest(pass)
    end
end
