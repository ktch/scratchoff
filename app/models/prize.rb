class Prize < ActiveRecord::Base
  belongs_to :admin
  validates :name, :presence => true
  validates :winmessage, :presence => true
  validates :redeemmessage, :presence => true
  validates :odds, :presence => true
  validates :admin_id, :presence => true
  
  attr_accessible :name, :winmessage, :redeemmessage, :suremessage, :odds, :inventory, :image, :weight
  
  default_scope :order => 'prizes.created_at DESC'
  
  mount_uploader :image, ImageUploader
  
  before_save :calculate_odds
  before_update :calculate_odds
  
  def calculate_odds
    odds = self.odds.split(':')
    overunder = odds.collect{|s| s.to_i}
    weight = overunder.first / (overunder.first + overunder.last).to_f
    self.weight = weight
  end

  # Chooses a random array element from the receiver based on the weights
  # provided. If _weights_ is nil, then each element is weighed equally.
  # 
  #   [1,2,3].random          #=> 2
  #   [1,2,3].random          #=> 1
  #   [1,2,3].random          #=> 3
  #
  # If _weights_ is an array, then each element of the receiver gets its
  # weight from the corresponding element of _weights_. Notice that it
  # favors the element with the highest weight.
  #
  #   [1,2,3].random([1,4,1]) #=> 2
  #   [1,2,3].random([1,4,1]) #=> 1
  #   [1,2,3].random([1,4,1]) #=> 2
  #   [1,2,3].random([1,4,1]) #=> 2
  #   [1,2,3].random([1,4,1]) #=> 3
  #
  # If _weights_ is a symbol, the weight array is constructed by calling
  # the appropriate method on each array element in turn. Notice that
  # it favors the longer word when using :length.
  #
  #   ['dog', 'cat', 'hippopotamus'].random(:length) #=> "hippopotamus"
  #   ['dog', 'cat', 'hippopotamus'].random(:length) #=> "dog"
  #   ['dog', 'cat', 'hippopotamus'].random(:length) #=> "hippopotamus"
  #   ['dog', 'cat', 'hippopotamus'].random(:length) #=> "hippopotamus"
  #   ['dog', 'cat', 'hippopotamus'].random(:length) #=> "cat"
  
end
# == Schema Information
# Table name: prizes
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  winmessage    :text
#  redeemmessage :text
#  odds          :string(255)
#  inventory     :integer
#  image         :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  admin_id      :integer
#

