# spec/requests/rooms_spec.rb
require 'rails_helper'

RSpec.describe 'Rooms API', type: :request do
  
  # add todos owner
  let(:user) { create(:user) }
  # initialize test data 
  let!(:rooms) { create_list(:room, 10, created_by: user.id) }
  let(:room_id) { rooms.first.id }

  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /rooms
  describe 'GET /rooms' do
    # make HTTP get request before each example
    before { get '/rooms', params: {}, headers: headers }

    it 'returns rooms' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /rooms/:id
  describe 'GET /rooms/:id' do
    before { get "/rooms/#{room_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the room' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(room_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:room_id) { 20 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Room/)
      end
    end
  end

  # Test suite for POST /rooms
  describe 'POST /rooms' do
    let(:valid_attributes) do
      # send json payload
      { title: 'Learn Vue', createdby: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/rooms', params: valid_attributes, headers: headers }

      it 'creates a room' do
        expect(json['title']).to eq('Learn Vue')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/rooms', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /rooms/:id
  describe 'PUT /rooms/:id' do
    let(:valid_attributes) { { title: 'Room 1' }.to_json }

    context 'when the record exists' do
      before { put "/rooms/#{room_id}", headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /rooms/:id
  describe 'DELETE /rooms/:id' do
    before { delete "/rooms/#{room_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end