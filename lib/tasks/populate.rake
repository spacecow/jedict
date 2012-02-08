task :populate => :environment do
  Glossary.generate('data/edict.txt') 
end

