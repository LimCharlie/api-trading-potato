module Api
  module V1
    class PotatoPricesController < ApplicationController
      # GET /potato_prices/:date
      def index
        date = params[:date]
        begin
          if date.present?
            date = DateTime.parse(date)
            potato_prices = PotatoPrice.by_time(date).ordered_by_time
            if potato_prices.any?
              list_of_potato_price_at_date = potato_prices.map { |potato| { time: potato.time, value: potato.value } }

              render json: list_of_potato_price_at_date
            else
              render json: { error: 'No potato prices available for the given date' }, status: :not_found
            end
          else
            render json: { error: 'No date given in params' }, status: :bad_request
          end
        rescue ArgumentError
          render json: { error: 'Date format error' }, status: :unprocessable_entity
        end
      end
    end
  end
end
