class V1::AccountResource < V1::BaseResource
  attributes :email

  has_many :tokens
end
