# require 'spec_helper'
# require 'rails_helper'

# describe V1::SessionsController, type: :controller do
#   let!(:login) { create(:login) }
#   let(:credentials) do
#     { session: { email: login.email, password: login.password } }
#   end

#   describe '#create' do
#     it 'returns 201' do
#       post :create, credentials

#       expect(response).to be_successful
#       expect(response.status).to eq 201
#     end

#     it 'returns 400' do
#       post :create, {}

#       expect(response).to_not be_successful
#       expect(response.status).to eq 400
#     end
#   end
# end
