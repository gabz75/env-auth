FactoryGirl.define do
  factory :token do
    transient do
      account nil
    end

    after(:create) do |token, factory|
      token.account = factory.account
      token.token = AuthToken.encode(id: factory.account.id)
    end
  end
end
