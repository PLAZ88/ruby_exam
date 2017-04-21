Rails.application.routes.draw do

  root 'sessions#index'
  get 'register' => 'sessions#register'
  get 'login' => 'sessions#login'
  post 'sessions' => 'sessions#create'
  delete 'sessions' => 'sessions#destroy'

  get 'lenders/:id' => 'lenders#show'
  post 'lenders' => 'lenders#create'
  # patch 'lenders/:id' => 'lenders#update'
  delete 'lenders/:id' => 'lenders#destroy'

  get 'borrowers/:id' => 'borrowers#show'
  post 'borrowers' => 'borrowers#create'
  # patch 'borrowers/:id' => 'borrowers#update'
  delete 'borrowers/:id' => 'borrowers#destroy'

  post 'transactions' => 'transactions#create'


end
