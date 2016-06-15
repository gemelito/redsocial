Rails.application.routes.draw do
  
  #Decimos que cuando se logen con facebook
  #repondremos con un controllador que se
  #llama onmiauth_callbacks
  devise_for :users, controllers:{
  	omniauth_callbacks: "users/omniauth_callbacks"
  }
  root 'main#home'
  
  #controlador para el formulario edit
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
