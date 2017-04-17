require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password

  validates_presence_of :username, message: 'Vui lòng nhập tên người dùng.'
  validates_length_of :username,
                      minimum: 6,
                      message: 'Tên người dùng phải có ít nhất 6 kí tự.'
  validates_uniqueness_of :username, message: 'Tên người dùng đã được sử dụng.'
  validates_format_of :username,
                      with: /\A[a-zA-Z0-9_.-]+\z/,
                      message: 'Tên người dùng không hợp lệ.'
  validates_presence_of :email, message: 'Vui lòng nhập email.'
  validates_uniqueness_of :email, message: 'Email đã được sử dụng.'
  validates_format_of :email,
                      with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i,
                      message: 'Email không hợp lệ.'
  validates_presence_of :password,
                        if: :password_required?,
                        message: 'Vui lòng nhập mật khẩu.'
  validates_length_of :password,
                      minimum: 6,
                      message: 'Mật khẩu phải có ít nhất 6 kí tự.'
  validates_confirmation_of :password,
                            message: 'Không khớp mật khẩu, vui lòng xác nhận lại.'

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
