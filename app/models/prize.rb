class Prize < ActiveRecord::Base
  belongs_to :admin
end
# == Schema Information
#
# Table name: prizes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  odds       :float
#  amount     :integer
#  image      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

