require 'spec_helper'
require 'rails_helper'

describe V1::TokensController, type: :controller do
  let!(:account) { create(:account) }
  let!(:credentials) do
    { account: { email: account.email, password: account.password } }
  end

  describe '#create' do
    it 'returns 201' do
      post :create, credentials

      expect(response).to be_successful, response.body
      expect(response.status).to eq 201
    end

    it 'returns 401' do
      post :create, { account: { email: 'wrong', password: 'wrong' }}

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 401
    end
  end
end
