require 'rails_helper'

RSpec.describe "User pages" do

  	subject { page }

  	describe "index" do
  		before(:each) do
  			sign_in user
  			visit users_path
  		end

  		it { should have_selector('title',	text: 'All users') }
  		it { should have_selector('h1',		text: 'All users') }

  		describe "pagination" do

  			it { should have_selector('div.pagination') }

	  		it "should list each user" do
	  			User.paginate(page: 1).each do |user|
	  				page.should have_selector('li',	text: user.name)
	  			end
	  		end
	  	end
  	end

  	describe "signup page" do
  		before { visit signup_path }

  		it { should have_selector('h1', text: 'Sign up') }
  		it {should have_selector('title', text: full_title('Sign up')) }
  	end

  	describe "profile page" do
  		# Code to make a user variable
  		before { visit user_path(user)}

  		it { should have_selector('h1', text: user.name) }
  		it { should have_selector('title', text:user.name) }
  	end

  	describe "signup" do
  		before { visit signup_path }

  		let(:submit) { "Create my account" }

  		describe "with invalid information" do
  			it "should not create a user" do
  				except { click_button submit }.not_to change(User, :count)
  			end
  		end

  		describe "with valid information" do
  			before do
  				fill_in "Name",			with: "Example User"
  				fill_in "Email"			with: "user@example.com"
  				fill_in "Password"  	with: "foobar"
  				fill_in "Confirmation"	with: "foobar"
  			end

  			it "should create a user" do
  				except { click_button submit } to change(User, :count).by(1)
  			end
  		end
  	end

  	describe "edit" do
  		before do
  			sign_in user
  			visit edit_user_path(user)
  		end

  		describe "page" do
  			it { should have_selector('h1',		text: "Update your profile") }
  			it { should have_selector('title',	text: "user") }
  			it { should have_link('change', href: 'https://en.gravatar.com/emails') }
  		end

  		describe "with invalid information" do
  			before { click_button "Save changes" }

  			it { should have_content('error') }
  		end

  		describe "with valid information" do
  			let(:new_name)	{ "New Name" }
  			let(:new_email) { "new@example.com" }
  			before do
  				fill_in "Name",				with: new_name
  				fill_in "Email",			with: new_email
  				fill_in "Password",			with: user.password
  				fill_in "Confirm Password",	with: user.password
  				click_button "Save Changes"
  			end

  			it { should have_selector('title', text: new_name) }
  			it { should have_selector('div.alert.alert-success') }
  			it { should have_link('Sign out', href: signout_path) }
  			specify { user.reload.name.should == new_name }
  			specify { user.reload.email.should == new_email }
  		end
  	end
end

