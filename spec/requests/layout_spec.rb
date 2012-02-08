require 'spec_helper'

describe "Layout" do
  describe "root" do
    it "takes you to the glossary index page" do
      visit root_path
      current_path.should eq root_path
    end
  end
end
