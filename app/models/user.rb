# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  username               :string           default(""), not null
#  name                   :string
#  lastname               :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
         
  has_many :posts
         
  validates :username, presence: true,uniqueness: true,length: {in: 3..12}
  #validacion personalizada
  validate :validate_username_regex
         
  #Metodo de clase para facebook que necesita de un paramtero
  def self.from_omniauth(auth)
    #Busca al usuario con el mismo provider y uid.
    #Si lo encuentra alguno retorno el primero
    #Si no lo crea.
    where(provider: auth[:provider], uid:auth[:uid]).first_or_create do |user|
    #Ejecuta un bloque de codigo para crear el usuario
    #Pregunta si existe un auth[:info] de facebook
  		if auth[:info]
  		  #Extrae el email y name del usuarios
  			user.email = auth[:info][:email]
  			user.name = auth[:info][:name]
  		end
  	  #Crea un password con la gem devise para el usuario
  		user.password = Devise.friendly_token[0,20]
  	end
  	
  end
  
   private
   #creamos la validacion personalizada
    def validate_username_regex
      #preguna que si no cumple el username con los caracteres declarados manda mensajes de error
      unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
        #Pasamos el username y el mensajes que se quiere mostrar
        errors.add(:username,"El username debe iniciar con una letra")
        errors.add(:username,"El username sólo puede contener _,letras y números")
      end
    end
  
end
