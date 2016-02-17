require 'spec_helper'
require 'rails_helper'

describe V1::LoginsController do
  describe '#create' do
    it 'returns 201' do
      post :create, { login: { email: 'login@example.com', password: 'qwertyuiop' } }

      expect(response).to be_successful, response.body
      expect(response.status).to eq 201
      expect(json['data']['type']).to eq 'logins'
      expect(json['data']['attributes']['email']).to eq 'login@example.com'
    end

    it 'returns 400' do
      post :create

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 400
    end
  end

  let!(:login) { create(:login) }
  let!(:session) { create(:session, login: login) }

  describe '#destroy' do
    it 'returns 204' do
      authenticate_request!(session.token)
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
      authenticate_request!(session.token)
      get :show

      expect(response).to be_successful, response.body
      expect(response.status).to eq 200
      expect(json['data']['type']).to eq 'logins'
      expect(json['data']['attributes']['email']).to eq login.email
    end

    it 'returns 401' do
      get :show

      expect(response).to_not be_successful, response.body
      expect(response.status).to eq 401
      expect(json['errors']).to include('Unauthorized')
    end
  end

end
