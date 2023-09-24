Rails.application.routes.draw do
  get "/", to: "home#api_data"
  get "/show_detail/:count", to: "home#show_detail"
  get '/search', to: 'home#search_results'
end
