module Api
  module V1
    module PotatoPrices
      class BestGainController < ApplicationController
        def show
          date = params[:date]
          begin
            date = DateTime.parse(date)
            potato_prices = PotatoPrice.by_time(date).ordered_by_time

            if potato_prices.length >= 2
              gain = best_gain(potato_prices)

              render json: { best_gain: gain }
            else
              render json: { error: 'Not enough potato prices for the given date to calculate gain' },
                     status: :unprocessable_entity
            end
          rescue ArgumentError
            render json: { error: 'Date format error' }, status: :unprocessable_entity
          end
        end

        private

        def best_gain(potato_prices)
          max_price = potato_prices.max_by(&:value)
          min_price = potato_prices.min_by(&:value)
          gain = 100 * (max_price.value - min_price.value)
          number_to_euro(gain)
        end

        def number_to_euro(gain)
          ActionController::Base.helpers.number_to_currency(gain, unit: '€', format: '%n %u', precision: 0)
        end
      end
    end
  end
end
