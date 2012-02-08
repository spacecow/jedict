# -*- coding: utf-8 -*-
require 'spec_helper'

describe Glossary do
  describe "#generate" do
    context "one word" do
      it "adds a glossary to the database" do
        lambda do
          Glossary.generate('data/edict_one_word.txt')
        end.should change(Glossary,:count).by(1)
      end
      it "sets the glossary name" do
        Glossary.generate('data/edict_one_word.txt')
        Glossary.last.name.should eq "銀河"
      end
      it "the glossary should have a definition" do
        Glossary.generate('data/edict_one_word.txt')
        Glossary.last.definitions.should eq [Definition.last]
      end

      it "adds a definiton to the database" do
        lambda do
          Glossary.generate('data/edict_one_word.txt')
        end.should change(Definition,:count).by(1)
      end
      it "sets the reading name of the definion" do
        Glossary.generate('data/edict_one_word.txt')
        Definition.last.reading.should eq "ぎんが"
      end

      it "adds meanings to the database" do
        lambda do
          Glossary.generate('data/edict_one_word.txt')
        end.should change(Meaning,:count).by(2)
      end
      it "sets the meanigs content" do
        Glossary.generate('data/edict_one_word.txt')
        Meaning.all.map(&:content).join(', ').should eq "(n) Milky Way, galaxy/(P)"
      end
      it "the definition should have meanings" do
        Glossary.generate('data/edict_one_word.txt')
        Definition.last.meanings.should eq [Meaning.first,Meaning.last]
      end
    end

    context "word with no reading" do
      it "adds a glossary to the database" do
        lambda do
          Glossary.generate('data/edict_no_reading.txt')
        end.should change(Glossary,:count).by(1)
      end

      it "the glossary name is set" do
        Glossary.generate('data/edict_no_reading.txt')
        Glossary.last.name.should eq 'あ'
      end

      it "adds a definition to the database" do
        lambda do
          Glossary.generate('data/edict_no_reading.txt')
        end.should change(Definition,:count).by(1)
      end

      it "the definiton reading is not set" do
        Glossary.generate('data/edict_no_reading.txt')
        Definition.first.reading.should be_nil 
      end
    end

    context "same word with two different readings" do
      it "adds one glossary to the database" do
        lambda do
          Glossary.generate('data/edict_two_words.txt')
        end.should change(Glossary,:count).by(1)
      end
      it "sets the glossary name" do
        Glossary.generate('data/edict_two_words.txt')
        Glossary.last.name.should eq "銀河"
      end
      it "the glossary should have two definitions" do
        Glossary.generate('data/edict_two_words.txt')
        Glossary.last.definitions.should eq Definition.all
      end

      it "adds definitions to the database" do
        lambda do
          Glossary.generate('data/edict_two_words.txt')
        end.should change(Definition,:count).by(2)
      end
      it "sets the definition reading" do
        Glossary.generate('data/edict_two_words.txt')
        Definition.all.map(&:reading).join('、').should eq "ぎんが、ぎんぎ"
      end

      it "adds meanings to the database" do
        lambda do
          Glossary.generate('data/edict_two_words.txt')
        end.should change(Meaning,:count).by(4)
      end
      it "sets the meanigs content" do
        Glossary.generate('data/edict_two_words.txt')
        Meaning.all.map(&:content).join(', ').should eq "(n) Milky Way, galaxy/(P), (n) Milky Way, galaxy/(P)"
      end
      it "the glossary should have meanings" do
        Glossary.generate('data/edict_two_words.txt')
        Definition.first.meanings.should eq Meaning.all[0..1]
        Definition.last.meanings.should eq Meaning.all[2..3]
      end
    end
  end #generate

  describe "#edict_name" do
    it "cuts out the name" do
      Glossary.edict_name("銀河 [ぎんが] /(n) (1) Milky Way/(2) galaxy/(P)/").should eq "銀河"
    end
  end #edict_name

  describe "#edict_reading" do
    it "cuts out the reading" do
      Glossary.edict_reading("銀河 [ぎんが] /(n) (1) Milky Way/(2) galaxy/(P)/").should eq "ぎんが"
    end
  end

  describe "#edict_meanings" do
    context "cuts out the meanings" do
      it "simple meaning" do
        Glossary.edict_meanings("銀河 [ぎんが] /(n) Milky Way/").should eq ["(n) Milky Way"] 
      end
      it "verb" do
        Glossary.edict_meanings("銀河 [ぎんが] /(v5s) Milky Way/").should eq ["(v5s) Milky Way"] 
      end
      it "two meanings" do
        Glossary.edict_meanings("銀河 [ぎんが] /(n) (1) Milky Way/yeah/(2) galaxy/(P)/").should eq ["(n) Milky Way/yeah","galaxy/(P)"] 
      end
      it "two meanings where 2nd starts with non-number" do
        Glossary.edict_meanings("銀河 [ぎんが] /(n) (1) Milky Way/yeah/(n) (2) galaxy/(P)/").should eq ["(n) Milky Way/yeah","(n) galaxy/(P)"] 
      end
    end
  end #edict_meanings

  context "#create_glossary" do
    it "no arguments creates an empty glossary" do
      lambda do
        lambda do
          lambda do
            create_glossary
          end.should change(Glossary,:count).by(1)
          Glossary.last.name.should eq "RSpec Name"
        end.should change(Definition,:count).by(0)
      end.should change(Meaning,:count).by(0)
    end

    it "one argument creates a glossary with name" do
      lambda do
        lambda do
          lambda do
            create_glossary("板垣")
          end.should change(Glossary,:count).by(1)
          Glossary.last.name.should eq "板垣"
        end.should change(Definition,:count).by(0)
      end.should change(Meaning,:count).by(0)
    end

    context "glossary with name and definition with reading" do
      it "second argument is a string" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣","いたがき")
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(0)
      end

      it "second argument is an array" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣",["いたがき"])
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(0)
      end

      after(:each) do
        Glossary.last.name.should eq "板垣"
        Glossary.last.definitions.should eq [Definition.last]
        Definition.last.reading.should eq "いたがき"
      end
    end

    context "glossary with name, definition with reading and meaning with content" do
      it "three arguments" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣","いたがき","fruit shop")
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(1)
      end

      it "second argument is an array" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣",["いたがき","fruit shop"])
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(1)
      end

      after(:each) do
        Glossary.last.name.should eq "板垣"
        Glossary.last.definitions.should eq [Definition.last]
        Definition.last.reading.should eq "いたがき"
        Definition.last.meanings.should eq [Meaning.last]
        Meaning.last.content.should eq "fruit shop"
      end
    end

    context "glossary with name, definition with reading and two meanings with content" do
      it "four arguments" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣","いたがき","fruit shop","meeting place")
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(2)
      end

      it "second argument array" do
        lambda do
          lambda do
            lambda do
              create_glossary("板垣",["いたがき","fruit shop","meeting place"])
            end.should change(Glossary,:count).by(1)
          end.should change(Definition,:count).by(1)
        end.should change(Meaning,:count).by(2)
      end

      after(:each) do
        Glossary.last.name.should eq "板垣"
        Glossary.last.definitions.should eq [Definition.last]
        Definition.last.reading.should eq "いたがき"
        Definition.last.meanings.should eq [Meaning.first,Meaning.last]
        Meaning.first.content.should eq "fruit shop"
        Meaning.last.content.should eq "meeting place"
      end
    end #four arguments...
    
    it "glossary with name and two readings" do
      lambda do
        lambda do
          lambda do
            create_glossary("板垣",["いたがき"],["ショップ"])
          end.should change(Glossary,:count).by(1)
          Glossary.first.name.should eq "板垣"
        end.should change(Definition,:count).by(2)
        Glossary.first.definitions.should eq [Definition.first,Definition.last]
        Definition.first.reading.should eq "いたがき"
        Definition.last.reading.should eq "ショップ"
      end.should change(Meaning,:count).by(0)
    end
  end
end
