FactoryGirl.define do
 factory :user do
    password "12345678"
    #pasamos el campo que se llenara de manera dinamica
    sequence(:email){|n| "dummy_#{n}@factory.com" }
    sequence(:username){|n| "username#{n}" }
  end
end
