Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "getRequest", to: "employees#index" 

  put "putReuqest", to: "employees#update"

end
