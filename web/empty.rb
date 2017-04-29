require 'redis'
require 'json'
require 'faker'

redis = Redis.new(:host => "localhost", :port => 6379, :db => 0)

#m = redis.get("lab5users")

#puts m
u = [["schwar12", "token"],
     # other tokens here
]

redis.set("lab5users", "{}")
u.each do |user, id|
  name = Faker::Name.unique.name 
  redis.hmset("lab5users", id, name)
end

