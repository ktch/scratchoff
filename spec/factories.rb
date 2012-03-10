Factory.define :admin do |admin|
  include ActionDispatch::TestProcess
  
  admin.name                   "Foo Bar"
  admin.email                  "foo@bar.com"
  admin.password               "foobar"
  admin.password_confirmation  "foobar"
end

Factory.define :prize do |prize|
  prize.name "Foo bar"
  prize.association :admin
end