Rails.application.routes.draw do
  
  #Es recomendable guardar las rutas en recurosos
  #Ya que espesifica el crud
  resources :posts
  #Declara el recurso usuarios y se sobre escribe con el nombre
  #users y el tercer parametro dice que solo utilizara
  #los recursos de mostrar y actilizar
  resources :usuarios, as: :users,only: [:show,:update]
  
  resources :usuarios, as: :users,only: [:show,:update]
  
  resources :friendships, only: [:create,:update,:index]
  
  #Decimos que cuando se logen con facebook
  #repondremos con un controllador que se
  #llama onmiauth_callbacks
  devise_for :users, controllers:{
  	omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  #controlador para el formulario edit
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up" 
  
  authenticated :user do
    root 'main#home'
  end

  unauthenticated :user do
    root 'main#unregistered'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
