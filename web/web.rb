require 'sinatra'
require 'redis'
require 'json'
require 'faker'

redis = Redis.new(:host => "localhost", :port => 6379, :db => 0)

helpers do
  def token_to_name(redis, token)
    a = redis.hmget("lab5users", token)
    if a.length == 1 and a[0] then
      return a[0]
    else
      "N/A"
    end
  end

  def replace_keys_with_names(redis, m)
    m.map {|k, v| 
      [token_to_name(redis, k), v] 
    }.to_h
  end

  def get_scores redis
    m = redis.hgetall("lab6map")
    m2 = {}
    m.each do |key, str|
      nk = token_to_name(redis, key)
      if nk != "N/A" then
        m2[nk] = JSON.parse(str)
        if m2[nk]["4"] == "-1" then
          m2[nk]["4"] = ""
        end
      end
    end

    m2.sort_by do |token|
     s = 0
     ["1", "2", "3"].each do |num|
       cur = token[1][num].to_i
       if cur == -1 then
         s += 99999
         token[1][num] = ""
       else
         s += cur
       end
     end
     s
    end
  end
end

set :port, 4432
set :bind, '0.0.0.0'

get '/name/:token' do
  token_to_name(redis, params['token'])
end

get '/change/:token' do
  name = token_to_name(redis, params['token'])
  if name == "N/A" then
    return "Invalid token"
  end
  token = params['token']
  type = params[:type]
  if type then
    if type == 'pokemon' then
      name = Faker::Pokemon.unique.name
    end

    if type == 'rick' then
      name = Faker::RickAndMorty.unique.character
    end

    if type == 'arnold' then
      name = Faker::HeyArnold.unique.character
    end

    if type == 'cat' then
      name = Faker::Cat.unique.name
    end

    if type == 'dragonball' then
      name = Faker::DragonBall.unique.character
    end

    if type == 'league' then
      name = Faker::LeagueOfLegends.character
    end
  else
    name = Faker::Name.unique.name
  end
  m = redis.hmset("lab5users", token, name)
  name
end

get '/lolscores' do
  content_type 'application/json'
  m = redis.hgetall("lab6map")
  replace_keys_with_names(redis, m).to_json
end

get '/test/1' do
	content_type 'text/plain'
  """
long g(long i) {
    return 1 + 223 + 392 - 439 + 12 * 12 / 4 * 271 - 32 + 329;
}

long f(long i) {
    return g(i) + 0 - 0 + 0 - 0 + 0 * 1;
}

long m(long i, long b, long c) {
	return ((c + -c)) - ((-c + c)) +
				 (327 * 37 - i + 8 - 394 / -2 - b);
}

long main() {
    long x, y, z;
    x = 81 * 127 - 238 / 8;
    y = f(1 * 28 - 439 / 2 + 192 * 12 / 43 - 128 / 12 * 43 / 12 - 12 * 12737);
    printf(\"%ld %ld\\n\", x, y);
}
"""
end

get '/test/2' do
	content_type 'text/plain'
	"""
long factorial(int num, long acc) {
  if (num == 0) 
    return acc;
  else
    return factorial(num - 1, acc * num);
}

long f() {
    if (32 - 2 * 16 + 1)
        if (1)
            if (0)
                if (1)
                    if (1)
                        return 12;
            else
                if (0)
                     return 13;
        else
            if (1)
                if (1)
                    return 15;
    else
        if ((293 + 35 - 43 * 12) + 188)
            return 23;

    while (5 == 1) {
        printf(\"neat\\n\");
    }

    return -1;   
}

long main() {
    long g, h, fac;
    g = f();
    scanf(\"%ld\\n\", &fac)
    h = factorial(fac, 1);
    printf(\"res = %ld, %ld\\n\", g, h);
}

"""
end

get '/test/3' do
content_type "text/plain"
"""
long a(long i) {
    return i * 1 / 1 - 0 + 1;
}

long b(long i) {
    return i * 1 / 1 - 0 + 2;
}

long c(long i) {
    long a, b, c, d, e, f, g, h;
    a = 1;
    b = 2;
    c = 3;
    d = 4;
    e = 5;
    f = 6;
    g = 7;
    h = 8;
    return a + b + c + d + e + f + g + h;
}

long bb(long x) {
    return x;
}

long f(long x) {
    return bb(x);
}

long g(long x) {
    return f(x);
}

long pred(long x) {
    if (x == 0)
       return 0;
    else
       return x - 1;
}

long ok(long y) {
    return pred(y) + pred(0) + pred(y + 1);
}

long main(){
    long x, y, z, vv, ww;

    x = (((1 < 2) > 3) * (2 + ((3 <= 2) >= 5)) * (10 + ((3 <= 2) >= 5))) * 0;
    y = (x + 0) + (x * 0) + (x * 1) * (-+-+-+-+-+-+-+-+-+-+-+-x);
    z = (x / 1) - (x + 0) + (x / 1) - (x - 0);
    printf(\"%ld %ld %ld\\n\", a(x), b(y), b(z) + 1);
    scanf(\"%ld %ld\\n\", &vv, &ww);
    printf(\"%ld\\n\", g(vv));
    printf(\"%ld\\n\", ok(ww));
}

"""
end

get '/test/4' do
content_type "text/plain"
"""
void printArray( long* a, long left, long right) {
  long i;
  for (i = left; i <= right; i = i+1) {
    printf(\"%ld \", a[i]);
  }
  printf(\"\\n\");
}

void print(char* s) {
  printf(\"==%s==\\n\", s);
}

long quicksortsubrange(long* a, long left, long right)
{
  long x, l, g, tmp;
  if (left >= right) {
    return 0;
  }

  x = a[right];

  l = left;
  g = right - 1;

  while (l<g) {
    while (l<g && a[l]<x) {
      l = l + 1;
    }

    while (l<g && a[g]>x) {
      g = g - 1;
    }

    if (l<g) {
      tmp = a[l];
      a[l] = a[g];
      a[g]=tmp;
    }
  }

  a[right]=a[l];
  a[l]=x;

  quicksortsubrange(a, left, l - 1);
  quicksortsubrange(a,g+1, right);
}

void quicksort(long* a, long n) {
  quicksortsubrange(a, 0, n - 1);
}

void shuffle(long* a, long n) {
  long i, j, t;
  for (i = 0; i < n - 1; i = i + 1) {
    j = rand() % n;
    t = a[j];
    a[j] = a[i];
    a[i] = t;
  }
}

void main() {
  long n, i;
  long* a;

  print(\"Hello\");

  n = 10;

  a = malloc(n*8);

  a[0] = 8;
  a[1] = 7;
  a[2] = 1;
  a[3] = 9;
  a[4] = 11;
  a[5] = 83;
  a[6] = 7;
  a[7] = 13;
  a[8] = 94;
  a[9] = 1;

  printf(\"-------- Before -------\\n\");
  printArray(a, 0, n - 1);
  for (i = 0; i < 5000000; i = i + 1) {
    shuffle(a, n - 1);
    quicksort(a, n);
  }

  printf(\"-------- After -------\\n\");
  printArray(a, 0, n - 1);
}
"""
end

get '/' do
  content_type 'text/html'
  scores = get_scores(redis)
  str = """
  <head>
  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>
  <title>CS352 Lab 6</title>
  </head>
  <body>
    <div class='container' style='width: 500px;'>
    <table class='table table-striped'>
    <tr>
      <td>Name</td>
      <td><a href='/test/1'>Test 1</a></td>
      <td><a href='/test/2'>Test 2</a></td>
      <td><a href='/test/3'>Test 3</a></td>
      <td><a href='/test/4'>Test 4</a></td>
    </tr>
  """
  bad  = "class='danger'"
  good = "class='success'"
  neutral = ""
  scores.each do |score|
    str += """
    <tr>
      <td>#{score[0]}</td>
      <td #{score[1]["1"] == "" ? bad : 
        (score[1]["1"].to_i < 2000 ? good : neutral)}>#{score[1]["1"]}</td>
      <td #{score[1]["2"] == "" ? bad : 
        (score[1]["2"].to_i < 2000 ? good : neutral)}>#{score[1]["2"]}</td>
      <td #{score[1]["3"] == "" ? bad : 
        (score[1]["3"].to_i < 2100 ? good : neutral)}>#{score[1]["3"]}</td>
      <td #{score[1]["4"] == "" ? bad : 
        (score[1]["4"].to_i < 5 ? good : neutral)}>#{score[1]["4"]} #{score[1]["4"] == "" ? "" : "sec"}</td>
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
