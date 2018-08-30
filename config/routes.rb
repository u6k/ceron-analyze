Rails.application.routes.draw do

  get '/api/feeds/download', to: 'feeds#download'

end
