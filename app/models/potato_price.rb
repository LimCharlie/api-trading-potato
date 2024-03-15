class PotatoPrice < ApplicationRecord
  scope :by_time, ->(date) { where(time: date.beginning_of_day..date.end_of_day) }
  scope :ordered_by_time, -> { order(:time) }
end
