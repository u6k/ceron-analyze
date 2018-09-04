Rails.application.routes.draw do

  post '/api/feeds/download', to: 'feeds#download'

end
