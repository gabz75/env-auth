FactoryGirl.define do
  factory :account do
    sequence(:email) { |n| "test-#{ n }@example.com " }
    password 'qwertyuiop'
  end
end
