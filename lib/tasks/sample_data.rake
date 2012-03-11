require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    superadmin = Admin.create!(:name => "Zach Phillips",
                  :subdomain => "zachary",
                  :email => "zhphillips@gmail.com",
                  :password => "1812war",
                  :password_confirmation => "1812war")
    superadmin.toggle!(:super)
    5.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password = "password"
      Admin.create!(:name => name,
                    :subdomain => Faker::Internet.domain_word,
                    :email => email,
                    :password => password,
                    :password_confirmation => password)
    end
    
    Admin.all.each do |admin|
      5.times do
        admin.prizes.create!(:name => Faker::Company,
                             :winmessage => Faker::Lorem.sentence(25),
                             :redeemmessage => Faker::Lorem.sentence(13),
                             :odds => "500:1000",
                             :inventory => 5,
                             :image => "img/prize.png")
      end
    end
    
  end
  
end

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