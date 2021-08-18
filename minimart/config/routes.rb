Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  mount GraphqlPlayground::Rails::Engine, at: '/', graphql_path: '/graphql'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
