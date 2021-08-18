Rails.application.routes.draw do
  mount GraphqlPlayground::Rails::Engine, at: '/', graphql_path: '/graphql'  
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
