def create_glossary(jap="RSpec Name",read=nil,mean=nil)
  glossary = Factory(:glossary,name:jap)
  glossary.definitions << create_definition(read,mean) if read
  glossary
end
