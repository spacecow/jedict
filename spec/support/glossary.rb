def create_glossary(jap="RSpec Name",*opt)
  glossary = Factory(:glossary,name:jap)
  if opt.first.instance_of? Array
    opt.each do |definition|
      glossary.definitions << create_definition(*definition)
    end
  else
    glossary.definitions << create_definition(*opt) if opt.first 
  end
  glossary
end
