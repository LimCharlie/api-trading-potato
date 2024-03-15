class CreatePotatoPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :potato_prices do |t|
      t.float :value
      t.datetime :time

      t.timestamps
    end
  end
end
