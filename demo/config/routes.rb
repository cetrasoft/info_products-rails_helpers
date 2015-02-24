Rails.application.routes.draw do
  get 'description_lists', to: 'high_voltage/pages#show', id: 'description_lists'
  get 'modals', to: 'high_voltage/pages#show', id: 'modals'
end
