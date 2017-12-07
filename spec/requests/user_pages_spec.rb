require 'rails_helper'

RSpec.describe "User pages" do

  	subject { page }

  	describe "signup page" do
  		before { visit signup_page }

  		it { should have_selector('h1', text: 'Sign up') }
  		it {should have_selector('title', text: full_title('Sign up')) }
  	end
end

