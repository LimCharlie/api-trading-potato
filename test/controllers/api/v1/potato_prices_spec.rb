require 'rails_helper'

RSpec.describe Api::V1::PotatoPricesController, type: :controller do
  describe 'GET #index' do
    context 'when providing a valid date' do
      let(:date) { Date.today }

      before do
        PotatoPrice.create(time: date.beginning_of_day + 1.hour, value: 50.0)
        PotatoPrice.create(time: date.end_of_day - 1.hour, value: 60.0)
      end

      it 'returns a success response' do
        get :index, params: { date: }

        expect(response).to have_http_status(:success)
      end
      it 'returns potato prices for the specified date' do
        get :index, params: { date: }

        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(PotatoPrice.by_time(date).count)
      end
    end

    context 'when providing an invalid date' do
      before { get :index, params: { date: 'invalid_date' } }

      it 'returns an unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Date format error')
      end
    end
  end
end
