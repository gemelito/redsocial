require 'rails_helper'

RSpec.describe User, type: :model do
    #Expectativas
    #ejemplo expect("uriel").to equals("Marcos")
    #Esperamos que los que tenemos se igual a lo que nos envian
    it { should validate_presence_of :username }
	it { should validate_uniqueness_of :username }
	it { should validate_uniqueness_of :username }
	
	it { should validate_length_of(:username).is_at_least(3).is_at_most(12) }
	
	describe "#validate_username_regex" do
	  let(:user){FactoryGirl.build(:user)}

	  it "should not allow username with numbers at the beginning" do
	  	user.username = "9asdasd"
	  	expect(user.valid?).to be_falsy
	  end

	  it "should not contain special characters" do
	  	user.username = "asdasd*"
	  	expect(user.valid?).to be_falsy
	  end

	end
end
