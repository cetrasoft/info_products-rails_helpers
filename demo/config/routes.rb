Rails.application.routes.draw do
  get 'demo', to: 'high_voltage/pages#show', id: 'demo'
end
