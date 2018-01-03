require 'rails_helper'

RSpec.describe Micropost, type: :model do
  
  before { @micropost = user.microposts.build(content: "Sphinx of black quartz, judge my vow")}

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		except do
  			Micropost.new(user_id: user.id)
  		end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "when user _id is not present" do
  	before { @micropost.user_id = nil }
  	it { should_not be_valid }
  end
end
