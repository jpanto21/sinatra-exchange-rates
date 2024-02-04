
  require "sinatra"
  require "sinatra/reloader"
  require "http"
  require "json"
  
  get("/") do
  
    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"

    raw_data = HTTP.get(api_url)
  
    raw_data_string = raw_data.to_s
  
    parsed_data = JSON.parse(raw_data_string)
  
    @symbols = parsed_data.fetch("currencies").keys

    erb(:homepage)
  end
 
  get("/:from_currency") do
    
    @original_currency = params.fetch("from_currency")

    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"

    raw_data = HTTP.get(api_url)
  
    raw_data_string = raw_data.to_s
  
    parsed_data = JSON.parse(raw_data_string)
  
    @symbols = parsed_data.fetch("currencies").keys

    erb(:from_currency)
  end


  get("/:from_currency/:to_currency") do

    @original_currency = params.fetch("from_currency")
    @destination_currency = params.fetch("to_currency")

    api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATES_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

    raw_data = HTTP.get(api_url)
  
    parsed_data = JSON.parse(raw_data)
  
    @conversion=parsed_data.fetch("result")

    erb(:to_currency)
   end
