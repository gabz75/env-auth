require 'spec_helper'
require 'rails_helper'

describe V1::AccountsController do
  describe '#create' do
    it 'returns 201' do
      post :create, { account: { email: 'account@example.com', password: 'qwertyuiop' } }

      expect(response).to be_successful, response.body
      expect(response.status).to eq 201
      expect(json['data']['type']).to eq 'accounts'
      expect(json['data']['attributes']['email']).to eq 'account@example.com'
    end

    it 'returns 400' do
      post :create

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 400
    end

    it 'returns 400 for duplicate accounts' do
      account = create(:account)
      post :create, { account: { email: account.email, password: account.password }}

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 400
      expect(json['errors']).to_not be_empty
    end
  end

  let!(:account) { create(:account) }
  let!(:token) { create(:token, account: account) }

  describe '#destroy' do
    it 'returns 204' do
      authenticate_request!(token.token)
      delete :destroy

      expect(response).to be_successful
      expect(response.status).to eq 204
    end

    it 'returns 401' do
      delete :destroy

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 401
      expect(json['errors']).to include('Unauthorized')
    end
  end

  describe '#show' do
    it 'returns 200' do
      authenticate_request!(token.token)
      get :show

      expect(response).to be_successful, response.body
      expect(response.status).to eq 200
      expect(json['data']['type']).to eq 'accounts'
      expect(json['data']['attributes']['email']).to eq account.email
    end

    it 'returns 401' do
      get :show

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 401
      expect(json['errors']).to include('Unauthorized')
    end
  end

end
