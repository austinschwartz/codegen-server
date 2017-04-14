require 'redis'
require 'json'
require 'faker'

redis = Redis.new(:host => "localhost", :port => 6379, :db => 0)

#m = redis.get("lab5users")

#puts m
u = [["aggarwak", "dw4biKljHFt1uX5Zt9bFir7YRXqlSlz"],
     ["galbrech", "Tl3uodKEZux4uNoGSjRTqGqi84sEkFY"],
     ["allen286", "7QmGQAKXSD3z7mqRuwhvadu2qNwHPys"],
     ["aaralis", "g0tG5bW6iKZ91JwyqWs466j0WR22I2h"],
     ["jaref", "d0mAsqhfX2ugpN2yRuHtbtOqRZ5XONS"],
     ["mashbeck", "iZMHoTzx9wF9uz4yUwqSis5stdsJqjx"],
     ["bagla", "xWGCCHF8yooDgZEn8qWnrhnQbucxZXh"],
     ["baker323", "bdffGAyqlzKIUPBhetzQXcl7vGO3fWP"],
     ["barber17", "JECG5ZcByyYBtPQTGV76o1pMHYlunJh"],
     ["sbassi", "i0JSz7oPQ5ZkjtDa2UV5aIwcF7yhZYb"],
     ["bbemis", "uSzGKcetqF8OnrGq94eUrXbUxhjjdyt"],
     ["ablejde", "adcHR2L6gDQFiKEWNl9Qw7sSSLBbiQE"],
     ["bond15", "9QM6c93AWzqYrlNUnlJauRr786tBC2c"],
     ["tborgard", "KtDOowIP8q89deZnQVvJ31HDBamWp8Q"],
     ["chang289", "hbqMHxoz0a5Py3WNRBDtbmPeSVBqJW0"],
     ["achellan", "bof5xA3eaQNzXu26PzoJrM1BeBEaiTu"],
     ["chen1564", "UspryAjDze0eq2mPfdnQI41zOmjl447"],
     ["chen1631", "KnuAQjXDlYOCZCi0NdtwxOPGINNc6AQ"],
     ["cheng171", "ydLXeBSuCC0cTB0oRI7yt9jDJvL2tcP"],
     ["schitka", "seQksqz207y3HwrM1sdlsXqT7EupVZ3"],
     ["christih", "8AStMV0ldrtz1Gdd1A799EFEIayYTUw"],
     ["davis791", "3xN1ENlzBFZ4lijUXXyHagbcXOiKou6"],
     ["adefano", "yW3t5XVUbqnY6GUf8Q1otPZF8koWKzn"],
     ["ding115", "tlCvzZNXNjzkuXlS8u5VB4fuPVtNa1A"],
     ["ding57", "8A6DneCrjWYM3KYi1RsdUbAe5lqtcqM"],
     ["ndunning", "KXse6F9LZn5lCEDZUL9Aeq92NIeL6C5"],
     ["aedelbro", "i6swHDaVvBgx7vxbAFdRBI9GRAxStwR"],
     ["aedlabad", "WklNYLIebuLE6g1cTK53Tx56YcQ5TxA"],
     ["erickso8", "iKINH3CWFChJgkPzgfRThrIj0y8K4Oh"],
     ["farmerp", "1ikD9UHzeEXMIc1Be6d2Sz9R9ho1x9B"],
     ["mfarrukh", "lVecXAFK2t6WgXk6UFYKx7dSeLtRZj9"],
     ["gouy", "dvhiMP7RU98QcxozODkG2PX6APn3YQ1"],
     ["ghackett", "mk5LphJwxJwX18T5ssXUcMGuKKT4AFf"],
     ["hahms", "dErkwDGkP1AN0t1cTeMCbxiHATdAqqV"],
     ["pheldrin", "oTIodng5wf6Dn11LvOib768oYbrteP8"],
     ["ahornin", "5rU2vMj8vzSsrlgIlvtZy2heoObMNBp"],
     ["ahouvena", "vvhMkfilkpKIctoi23OQbCZBRMOC0lH"],
     ["hughe127", "9URaomrbdiqWXR7CGAG4e7tji6pCQIS"],
     ["jiang385", "9GEDWk901vUPfTCfQxfl0S4edKZNfqm"],
     ["jiangv", "JbXHRw4yduw0PmxSmrvDgjZSAuesEXQ"],
     ["pkadiwal", "01sPNDZ6rQSKgxo0ThYhor39fnwtmHx"],
     ["ekartono", "xk7nkETmFRDLCRg3Q6qoFY2kAeJHkQX"],
     ["kingh", "QSLgJk2jRvhkVZUnxptPQJhwwVki2ll"],
     ["kramer40", "UYKURmQpypgN1KoCE1KmyJKEMLUuVgp"],
     ["ilepow", "BHKJ83dRNMgP5pIaIPKsEqpZdw7Dtcv"],
     ["luo106", "HFLSLliDjX7e34KId4kl2cLtJBNp7mP"],
     ["kalutes", "QFEu7AgVTBj2kfyc7pIpFb0d0hfkRxC"],
     ["amansin", "Iboh8THQMw0NPWpg2OZT3DVdTqHkuCr"],
     ["mill1630", "kwWoLSb3yX2BE06I88d4Q6sz67xfKAz"],
     ["moore585", "8bUAkEQU3gTpKDK0mKphJLA49ugknEL"],
     ["nairs", "pedCGB55PvAmVIeHXRSyPBaGtmKvE2s"],
     ["nathan", "B4r4g84NZNQh7ngpc8ovq01rLMSAd3K"],
     ["nnevius", "MtoaF0vl2zOMqoFlYwVJ8SSMqUyZeB5"],
     ["rorikata", "0RYk0EF0c4WsUmADZepRFufk1ehp4Sl"],
     ["page38", "Sta33EkOTyYxU22bc6icclVoQmJ0DQz"],
     ["pan95", "1Kpnt3zM798uBLs3Q80ENVruBsROEzV"],
     ["pan176", "nTfRx1UhbQWi2ujUhg3dugMtEJWiiUU"],
     ["npurohit", "oCKal5oLu8jvCEYKGy2dedBrg90P8d9"],
     ["roth28", "w76HiVIsYQpJgyM6ZDGAzn4RRc7UDxC"],
     ["krustagi", "525rKsYSPS6x0p2io0OIr8iJ5neeKIF"],
     ["saxena12", "mK2EqKUKGIs5NbNBNPauIA58Ab515XJ"],
     ["cschlat", "arhKqKtVIobOxDTmBYWtr6RQZnpk72n"],
     ["seto", "vdAHVm9KrBLAdjTQS82yvpBkM1WoClV"],
     ["shi249", "xDWF0DoXx7yfa7B8NtwabrsTJOZxd98"],
     ["shin197", "oXRu7w1lt2Bg0woFA4WjJ52IUgOw7Uu"],
     ["yshiroya", "SjbikoiKzOSbsRrWZpakKhePuomiDqt"],
     ["tsiah", "fKTw5vF0PxjwcWYZvsm2CXo1w6YJAap"],
     ["singh200", "XQEq0bwaeRXdYM2qof0PPJJOWrvyPfv"],
     ["ispooner", "5Yy0Y9oRul40wyDcrheKMaNo4LhaF3f"],
     ["stuart4", "ukqQ932pgcbPnZxVUu16QtyUCmSC7DL"],
     ["sun375", "72cpUqHo2CQt2usocSEEfG5d08OLmsx"],
     ["tang184", "hImHkhKocoBzPAwKHUngw8KVKWxptES"],
     ["trankq", "bRllz4w5OP6hyWqCaUOhVfA8LH8cVX2"],
     ["avempaty", "8uQgCTRmszmDBL11Wz5EIn8aO3AqMiD"],
     ["avijaywa", "ZWwFu27X0CszGaAvUqcarX6zhCoPCsJ"],
     ["nwhaley", "WG0nCl0WwLj08RUfdGh1ZXDKkvTMEuJ"],
     ["wu689", "ejYjffUFnWYNMqrhZEmZMsaoquqKdAO"],
     ["xiao72", "FWXgTwvDHa3rChOFce7So8w8429vqFF"],
     ["xiong28", "SsuHV6vV7HqOuNmyfxgXlUfOa5SNyLz"],
     ["xu675", "2DrTXOmpNv9kAg7FgwF8EeizLaGwwNL"],
     ["yan182", "XtQQx5qQsZ9w4weTofGCY0ZlF47ODOE"],
     ["yan166", "QkOnXXpShmW3px3LysLySTfybEGFjO0"],
     ["yang961", "lOO9QVvv2dOBgCKQQsofEgbZdmCD1fS"],
     ["yin56", "KJXtjeg0Ns3w7gXxnRJhQ8KVHjznbj2"],
     ["zhan1997", "RJ0xW34gh0jYPRH6EitzIyEa4J2VDBz"],
     ["vzhang", "gSD9TbXiyr83QEFWENhn0RWDWNvHob0"],
     ["zhan1613", "8b7YXf9FaYead2SalUSQLc4Q6mO8XQ0"],
     ["zheng248", "sDiDjFcgg4oD9YyODfsYBb8KXOTzzNu"],
     ["zhou482", "3AkGofSwAVELKfrn4dH7RGggGvlvF0F"],
     ["zhu442", "3AqSGtviKlICu2PK48nuiqEbsi9N51S"],
     ["schwar12", "fLXK3weGEYpSbRI5jNvObgd2AcU9gr2"],
     ["hays1", "m2idLk694MCCxgF6m7zSoZA2FFios4G"],
     ["horton7", "jEZs37ZKWM0oeLHDbIYTxuKGqs3NUOg"],
     ["fieldn", "6jFdt1YppX26cmDZygTxiGJo56qZZc6"],
     ["wu636", "0mBPRlqgtKUqW3rq8kwtVBf6cocscUU"]]

#redis.set("lab5users", "{}")
u.each do |user, id|
  name = Faker::Name.unique.name 
  redis.hmset("lab5users", id, name)
end
