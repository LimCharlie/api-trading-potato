# spec/controllers/api/v1/potato_prices/best_gain_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::PotatoPrices::BestGainController, type: :controller do
  describe 'GET #show' do
    context 'with valid date parameter' do
      let(:date) { Date.today }
      let!(:potato_price1) { PotatoPrice.create(time: date, value: 100.25) } # in scope
      let!(:potato_price2) { PotatoPrice.create(time: date, value: 100.29) } # in scope
      let!(:potato_price3) { PotatoPrice.create(time: date + 1.day, value: 200.0) }

      it 'returns the best gain for the specified date' do
        get :show, params: { date: }
        expect(response).to have_http_status(:success)

        json_response = JSON.parse(response.body)
        expect(json_response['best_gain']).to eq('4 €')
      end
    end

    context 'with invalid date parameter' do
      it 'returns unprocessable entity status' do
        get :show, params: { date: 'invalid_date' }
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Date format error')
      end
    end

    context 'with insufficient potato prices for the date' do
      let(:date) { Date.today }
      let!(:potato_price) { PotatoPrice.create(time: date, value: 100.0) }

      it 'returns unprocessable entity status' do
        get :show, params: { date: }
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Not enough potato prices for the given date to calculate gain')
      end
    end
  end
end
