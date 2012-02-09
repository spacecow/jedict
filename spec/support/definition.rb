def create_definition(read,*opt)
  definition = Factory(:definition,reading:read)
  opt.each do |mean|
    definition.meanings << create_meaning(mean)
  end
  definition
end
