# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Glossaries" do
  describe "index" do
    context "layout, without glossaries" do
      before(:each){ visit glossaries_path }

      it "have a title" do
        page.should have_title('Glossaries')
      end

      it "has a table for the glossaries" do
        page.should have_a_table('glossaries')
      end

      it "table has a table header" do
        tableheader.should eq %w(Japanese Reading)
      end
    end #layout, without glossaries

    context "layout, with glossary" do
      before(:each) do
        create_glossary("板垣")
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq %w(板垣)
      end
    end

    context "layout, with glossary and definition" do
      before(:each) do
        create_glossary("板垣","いたがき")
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq %w(板垣 いたがき)
      end
    end
  end
end
