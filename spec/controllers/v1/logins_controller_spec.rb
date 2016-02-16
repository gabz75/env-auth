require 'spec_helper'
require 'rails_helper'

describe V1::LoginsController do
  describe '#create' do
    it 'returns 201' do
      post :create, { login: { email: 'login@example.com', password: 'qwertyuiop' } }

      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(json['data']['type']).to eq 'logins'
      expect(json['data']['attributes']['email']).to eq 'login@example.com'
    end

    it 'returns 400' do
      post :create

      expect(response).to_not be_successful
      expect(response.status).to eq 400
    end
  end

  let!(:login) { create(:login) }

  describe '#destroy' do
    before(:each) { create(:session, login: login) }

    it 'returns 204' do
    end

    it 'returns 401' do
      delete :destroy

      expect(response).to_not be_successful
      expect(response.status).to eq 401
      expect(json['errors']).to include('authentication required')
    end
  end

  describe '#show' do
    it 'returns 200' do
    end

    it 'returns 401' do
      get :show

      expect(response).to_not be_successful
      expect(response.status).to eq 401
      expect(json['errors']).to include('authentication required')
    end
  end

end
