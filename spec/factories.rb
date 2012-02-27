Factory.define :admin do |admin|
  include ActionDispatch::TestProcess
  
  admin.name                   "Foo Bar"
  admin.email                  "foo@bar.com"
  admin.password               "foobar"
  admin.password_confirmation  "foobar"
  admin.logo                   "fake/image.jpg"
end