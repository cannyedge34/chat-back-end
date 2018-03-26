# spec/requests/messages_spec.rb
require 'rails_helper'

RSpec.describe 'Messages API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:room) { create(:room, created_by: user.id) }
  let!(:messages) { create_list(:message, 20, room_id: room.id, created_by: user.id) }
  let(:room_id) { room.id }
  let(:id) { messages.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /rooms/:room_id/messages
  describe 'GET /rooms/:room_id/messages' do
    before { get "/rooms/#{room_id}/messages", params: {}, headers: headers }

    context 'when room exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all room messages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when room does not exist' do
      let(:room_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Room/)
      end
    end
  end

  # Test suite for POST /rooms/:room_id/messages
  describe 'POST /rooms/:room_id/messages' do
    let(:valid_attributes) { { content: 'Hi buddy!', created_by: user.id }.to_json }
    let(:invalid_attributes) { { content: 'Hi John!' }.to_json }
    context 'when request attributes are valid' do
      before { post "/rooms/#{room_id}/messages", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/rooms/#{room_id}/messages", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        # expect(response.body).to match(/Validation failed: Name can't be blank/)
        expect(response.body).to eq('{"message":"Validation failed: Content can\'t be blank"}')
      end
    end
  end

end