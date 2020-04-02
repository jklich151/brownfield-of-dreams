require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe "methods" do
    before :each do
      @user = User.create!(email: 'jennyklich@gmail.com',
                          first_name: 'Jenny',
                          last_name: 'Klich',
                          password: 'JennyGithub',
                          role: 0,
                          github_token: ENV['Github_token_jenny'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "#repos" do
      expect(@user.repos.count).to eq(5)
    end

    it "#following" do
      expect(@user.following.count).to eq(6)
    end

    it "#followers" do
      expect(@user.followers.count).to eq(2)
    end
  end
end
