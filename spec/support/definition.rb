def create_definition(read,*opt)
  definition = Factory(:definition,reading:read)
  definition.meanings << create_meaning(opt.first) if opt.first 
  definition
end
