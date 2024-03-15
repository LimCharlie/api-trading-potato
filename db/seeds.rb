# db/seeds.rb
100.times do |_i|
  random_hour = rand(0..23)
  random_minute = rand(0..59)
  random_second = rand(0..59)

  time_now_with_random_hour = Time.new(Time.now.year, Time.now.month, Time.now.day, random_hour, random_minute,
                                       random_second)
  price_value = rand(50.0..200.0).round(2)
  PotatoPrice.create(time: time_now_with_random_hour, value: price_value)
end
