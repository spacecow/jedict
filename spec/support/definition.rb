def create_definition(read,mean=nil)
  definition = Factory(:definition,reading:read)
  definition.meanings << create_meaning(mean) if mean
  definition
end
