class GlossariesController < ApplicationController
  def index
    @glossaries = Glossary.scoped
  end
end
