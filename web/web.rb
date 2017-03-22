require 'sinatra'
require 'redis'
require 'json'

redis = Redis.new(:host => "localhost", :port => 6379, :db => 0)

helpers do
  def get_scores redis
    m = JSON.parse(redis.get("lab5map"))
    m.map{|k, v| [k, v]}
     .sort{|x1, x2| x1[1] <=> x2[1]}
     .map.with_index{|x, i| [i + 1, x].flatten}
  end
end

set :port, 4432
set :bind, '0.0.0.0'

get '/api' do
  content_type 'application/json'
  m = redis.get("lab5map")
  m
end

get '/' do
  content_type 'text/html'
  scores = get_scores(redis)
  str = """
  <head>
  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>
  </head>
  <body>
    <div class='container' style='width: 500px;'>
    <table class='table'>
      <tr>
        <th>Index</th>
        <th>Career Acc</th>
        <th>Score</th>
      </tr>
  """
  scores.each do |i, careerAcc, score|
    str += """
    <tr>
      <td>#{i}</td>
      <td>#{careerAcc}</td>
      <td>#{score}</td>
    </tr>
    """
  end
  str += """
    </table>
    </div>
  </body>
  """
  str
end
