def create_glossary(jap="RSpec Name",*opt)
  glossary = Factory(:glossary,name:jap)
  glossary.definitions << create_definition(*opt) if opt.first 
  glossary
end
