require 'spec_helper'
require 'rails_helper'

describe V1::SessionsController, type: :controller do
  let!(:login) { create(:login) }
  let!(:credentials) do
    { session: { email: login.email, password: login.password } }
  end

  describe '#create' do
    it 'returns 201' do
      post :create, credentials

      expect(response).to be_successful, response.body
      expect(response.status).to eq 201
    end

    it 'returns 401' do
      post :create, { session: { email: 'wrong', password: 'wrong' }}

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 401
    end
  end
end
