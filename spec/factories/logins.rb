FactoryGirl.define do
  factory :login do
    sequence(:email) { |n| "test-#{ n }@example.com " }
    password 'qwertyuiop'
  end
end
