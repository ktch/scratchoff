Factory.sequence :email do |n|
  "test#{n}@example.com"
end

Factory.sequence :subdomain do |n|
  "test#{n}"
end

Factory.define :admin do |admin|
  admin.subdomain              { Factory.next(:subdomain) }
  admin.name                   "Foo Bar"
  admin.email                  { Factory.next(:email) }
  admin.password               "foobar"
  admin.password_confirmation  "foobar"
end

Factory.define :prize do |prize|
  prize.association :admin
  prize.name "Foo bar"
  prize.winmessage "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quam ante, feugiat eu mattis pretium, posuere non leo. In egestas dui ut purus volutpat faucibus. Curabitur blandit rutrum ante, ut varius libero interdum non. Curabitur lobortis, justo sit amet vestibulum viverra, erat felis vestibulum tellus, elementum pharetra lectus magna sed arcu. Ut a adipiscing lacus. Class aptent taciti sociosqu ad."
  prize.redeemmessage "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quam ante, feugiat eu mattis pretium, posuere non leo. In egestas dui ut purus volutpat faucibus. Curabitur blandit rutrum ante, ut varius libero interdum non. Curabitur lobortis, justo sit amet vestibulum viverra, erat felis vestibulum tellus, elementum pharetra lectus magna sed arcu. Ut a adipiscing lacus. Class aptent taciti sociosqu ad."
  prize.odds "500:1000"
  prize.inventory 10
end