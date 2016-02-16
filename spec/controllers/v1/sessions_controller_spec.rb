require 'spec_helper'
require 'rails_helper'

describe V1::SessionsController, type: :controller do
  let(:login) { create(:login) }
  let(:credentials) do
    { login: { email: login.email, password: login.password } }
  end

  describe '#create' do
    it 'returns 201' do
      post :create, credentials

      expect(response).to be_successful
    end
  end
end
