require 'spec_helper'

describe Membership do
  it "if none amount 0" do 
    expect(Membership.count).to be(0)
  end
end
