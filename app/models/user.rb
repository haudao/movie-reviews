require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password

  validates_presence_of :username, message: I18n.t(:usr_blank_err)
  validates_length_of :username,
                      minimum: 6,
                      message: I18n.t(:usr_length_err)
  validates_uniqueness_of :username, message: I18n.t(:usr_unique_err)
  validates_format_of :username,
                      with: /\A[a-zA-Z0-9_.-]+\z/,
                      message: I18n.t(:usr_val_err)
  validates_presence_of :email, message: I18n.t(:email_blank_err)
  validates_uniqueness_of :email, message: I18n.t(:email_unique_err)
  validates_format_of :email,
                      with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i,
                      message: I18n.t(:email_val_err)
  validates_presence_of :password,
                        if: :password_required?,
                        message: I18n.t(:pwd_blank_err)
  validates_length_of :password,
                      minimum: 6,
                      message: I18n.t(:pwd_length_err)
  validates_confirmation_of :password,
                            message: I18n.t(:pwd_confirm_err)

  before_save :encrypt_new_password

  def self.authenticate(username, password)
    user = find_by_username(username)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  protected

  def encrypt_new_password
    return if password.blank?
    self.hashed_password = encrypt(password)
  end

  def password_required?
    hashed_password.blank? || password.present?
  end

  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
end
