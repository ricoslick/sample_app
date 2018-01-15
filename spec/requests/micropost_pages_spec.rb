require 'rails_helper'

RSpec.describe "MicropostPages", type: :request do
 	subject { page }

	before { sign_in user }

	describe "micropost creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a micropost" do
				except { click_button  "Post" }.should_not change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'micropost_content', with: "Sphinx of black quartz, judge my vow" }
			it "should create a micropost" do
				expect { click_button "Post" }.should change(Micropost, :count).by(1)
			end
		end
	end
end
