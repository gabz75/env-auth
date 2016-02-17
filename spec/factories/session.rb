FactoryGirl.define do
  factory :session do
    transient do
      login nil
    end

    after(:create) do |session, factory|
      session.login = factory.login
      session.token = AuthToken.encode(id: factory.login.id)
    end
  end
end
