require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it { should belong_to :user }
  it { should belong_to :friend }

  it "should validate uniqueness of user with friend" do
    #Creamos al primer usuarios para que el envia una amistad al segundo que se crea
  	user = FactoryGirl.create(:user)
  	friend = FactoryGirl.create(:user)

    #Pasamos que el primer usuarios le envia amistag al segunto
    #esto pasa porque solo envia uno
  	FactoryGirl.create(:friendship,user: user, friend: friend)

    #diuplica la amistas para procesar el envio
  	amistad_duplicada = FactoryGirl.build(:friendship,user: user, friend: friend)

    #Pasamos que es flaso la amista que que no puede enviaer dos veces la misma amistad
  	expect(amistad_duplicada.valid?).to be_falsy

	end
end
