class Admin < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :logo, :password, :password_confirmation
  
  mount_uploader :logo, LogoUploader
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,      :presence   => true,
                        :length     => { :maximum => 50 }
  validates :email,     :presence   => true,
                        :uniqueness => { :case_sensitive => false },
                        :format     => { :with => email_regex }
  validates :password,  :confirmation => true,
                        :presence     => true,
                        :length       => { :within => 6..40 }
  # validates :logo,      :presence => true

  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  class << self
    def authenticate(email, submitted_password)
      admin = find_by_email(email)
      (admin && admin.has_password?(submitted_password)) ? admin : nil
    end
  
    def authenticate_with_salt(id, cookie_salt)
      admin = find_by_id(id)
      (admin && admin.salt == cookie_salt) ? admin : nil
    end
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
# == Schema Information
#
# Table name: admins
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  logo               :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

