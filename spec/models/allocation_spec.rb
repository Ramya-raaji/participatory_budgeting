require 'rails_helper'

RSpec.describe Allocation, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:project) { Project.create!(name: "Test Project", cost: 1000) }

  it "is valid with a valid amount within budget" do
    allocation = Allocation.new(user: user, project: project, amount: 500)
    expect(allocation).to be_valid
  end

  it "is invalid if allocation exceeds user budget" do
    Allocation.create!(user: user, project: project, amount: 900)
    allocation2 = Allocation.new(user: user, project: Project.create!(name: "Another", cost: 1000), amount: 200)
    expect(allocation2).not_to be_valid
    expect(allocation2.errors[:amount]).to include("exceeds your $1,000 voting budget")
  end
end
