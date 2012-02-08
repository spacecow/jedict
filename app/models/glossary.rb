class Glossary < ActiveRecord::Base
  has_many :definitions
  validates :name, :presence => true

  class << self
    def generate(file)
      File.open(file,'r') do |f|
        while(line = f.gets)
          glossary = Glossary.find_or_create_by_name(edict_name(line))
          definition = Definition.create(:reading=>edict_reading(line))
          glossary.definitions << definition
          edict_meanings(line).each do |meaning|
            definition.meanings << Meaning.create(:content=>meaning) unless definition.meanings.map(&:content).include?(meaning)
          end
        end
      end 
    end

    def edict_name(s) s.split[0] end
    def edict_reading(s) s.split[1][1..-2] end
    def edict_meanings(s)
      arr = s.split[2..-1].join(' ').split(/\(\d+\)/)
      if arr.count == 1
        arr.map{|e| e[1..-2]} 
      else
        prev = ""
        ret = [] 
        arr.each do |part|
          if part[-1] == '/'
            ret.push(prev + part.split('/')[0..-1].join('/').lstrip)
            prev = "" 
          else
            ret.push(prev + part.split('/')[0..-2].join('/').lstrip)
            prev = part.split('/')[-1]
          end
        end
        ret.shift
        ret
      end
    end
  end
end
