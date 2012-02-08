require 'spec_helper'

describe "Glossaries" do
  describe "index" do
    context "layout" do
      before(:each){ visit glossaries_path }

      it "should have a title" do
        page.should have_title('Glossaries')
      end
    end
  end
end
