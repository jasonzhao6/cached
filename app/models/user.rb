class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

require 'bcrypt'

class User < ActiveRecord::Base
  has_many :tweets
  has_many :hash_tags
  
  # users.password_hash in the database is a :string
  include BCrypt

  validates :email, presence: true, uniqueness: true, email: true
  validates :password_hash, presence: true
  
  def password
    @password ||= Password.new password_hash
  end
  
  def password= new_password
    @password = Password.create new_password
    self.password_hash = @password
  end
  
end