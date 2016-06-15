require 'rails_helper'

RSpec.describe User, type: :model do
    #Expectativas
    #ejemplo expect("uriel").to equals("Marcos")
    #Esperamos que los que tenemos se igual a lo que nos envian
    it { should validate_presence_of :username }
	it { should validate_uniqueness_of :username }
	it { should validate_uniqueness_of :username }
	
	it { should validate_length_of(:username).is_at_least(3).is_at_most(12) }
end
