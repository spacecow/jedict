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
        tablerow(0).should eq ["板垣","",""]
      end
    end

    context "layout, with glossary and definition" do
      before(:each) do
        create_glossary("板垣","いたがき")
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき",""]
      end
    end

    context "layout, with glossary, definition and meaning" do
      before(:each) do
        create_glossary("板垣","いたがき","fruit shop")
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき","fruit shop"]
      end
    end

    context "layout, with glossary, definition and two meanings" do
      before(:each) do
        create_glossary("板垣","いたがき","fruit shop","meeting place")
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき","fruit shop"]
        tablerow(1).should eq ["","","meeting place"]
      end
    end

    context "layout, with glossary and two definitions" do
      before(:each) do
        create_glossary("板垣",["いたがき"],["ショップ"])
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき",""]
        tablerow(1).should eq ["","ショップ",""]
      end
    end

    context "layout, with glossary and two definitions and 1+0 meanings" do
      before(:each) do
        create_glossary("板垣",["いたがき","fruit shop"],["ショップ"])
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき","fruit shop"]
        tablerow(1).should eq ["","ショップ",""]
      end
    end

    context "layout, with glossary and two definitions and 2+0 meanings" do
      before(:each) do
        create_glossary("板垣",["いたがき","fruit shop","meeting place"],["ショップ"])
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき","fruit shop"]
        tablerow(1).should eq ["","","meeting place"]
        tablerow(2).should eq ["","ショップ",""]
      end
    end

    context "layout, with glossary and two definitions and 1+1 meanings" do
      before(:each) do
        create_glossary("板垣",["いたがき","fruit shop"],["ショップ","meeting place"])
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき","fruit shop"]
        tablerow(1).should eq ["","ショップ","meeting place"]
      end
    end

    context "layout, with glossary and two definitions and 0+2 meanings" do
      before(:each) do
        create_glossary("板垣",["いたがき"],["ショップ","fruit shop","meeting place"])
        visit glossaries_path
      end

      it "table has one row and one col" do
        tablerow(0).should eq ["板垣","いたがき",""]
        tablerow(1).should eq ["","ショップ","fruit shop"]
        tablerow(2).should eq ["","","meeting place"]
      end
    end
  end
end
