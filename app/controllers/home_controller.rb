class HomeController < ApplicationController
  require 'net/http'
  require 'json'
  def api_data
    uri = URI(Rails.application.config.external_api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    data = {
        select_type: 'geometry',
        maxResults: 100,
      }
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{Rails.application.config.external_api_key}"
      request.body = data.to_json

      response = http.request(request)
      result = JSON.parse(response.body)

      @natures = result['resultsets']['features'].map do |feature|
        feature['properties']['nature']
      end

      @dates = result['resultsets']['features'].map do |feature|
        feature['properties']['date']
      end

      @agendas = result['resultsets']['features'].map do |feature|
        feature['properties']['agenda']
      end

      @results = result['resultsets']['features'].map do |feature|
        feature['properties']['result']
      end

      @agreements = result['resultsets']['features'].map do |feature|
        feature['properties']['agreement']
      end

      @oppositions = result['resultsets']['features'].map do |feature|
        feature['properties']['opposition']
      end

      @supporters = result['resultsets']['features'].map do |feature|
        feature['properties']['supporter']
      end

      @opponentss = result['resultsets']['features'].map do |feature|
        feature['properties']['opponents']
      end

      @numbers = result['resultsets']['features'].map do |feature|
        feature['properties']['number']
      end

      session[:natures] = @natures
      session[:dates] = @dates
      session[:agendas] = @agendas
      session[:results] = @results
      session[:agreements] = @agreements
      session[:oppositions] = @oppositions
      session[:supporters] = @supporters
      session[:opponentss] = @opponentss
      session[:numbers] = @numbers
      render 'api_data'

    end

    def search_results
      @re = params[:result]
      @natures = session[:natures]
      @dates = session[:dates]
      @agendas = session[:agendas]
      @results = session[:results]
      @agreements = session[:agreements]
      @oppositions = session[:oppositions]
      @supporters = session[:supporters]
      @opponentss = session[:opponentss]
      @numbers = session[:numbers]
      render 'home/search_results'    
    end
    







    def show_detail
      count = params[:count]

      @natures = session[:natures]
      @dates = session[:dates]
      @agendas = session[:agendas]
      @results = session[:results]
      @agreements = session[:agreements]
      @oppositions = session[:oppositions]
      @supporters = session[:supporters]
      @opponentss = session[:opponentss]
      @numbers = session[:numbers]

      @nature = @natures[count.to_i]
      @date = @dates[count.to_i]
      @agenda = @agendas[count.to_i]
      @result = @results[count.to_i]
      @agreement = @agreements[count.to_i]
      @opposition = @oppositions[count.to_i]
      @supporter = @supporters[count.to_i]
      @opponents = @opponentss[count.to_i]
      @number = @numbers[count.to_i]
    end

end



  


