require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Admin.create!(:name => "Zach Phillips",
                  :email => "zhphillips@gmail.com",
                  :password => "1812war",
                  :password_confirmation => "1812war")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password = "password"
      Admin.create!(:name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password)
    end
  end
  
end