class Admin < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :logo, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,      :presence   => true,
                        :length     => { :maximum => 50 }
  validates :email,     :presence   => true,
                        :uniqueness => { :case_sensitive => false },
                        :format     => { :with => email_regex }
  validates :password,  :confirmation => true,
                        :presence     => true,
                        :length       => { :within => 6..40 }
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
#

