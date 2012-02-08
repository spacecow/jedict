class Definition < ActiveRecord::Base
  belongs_to :glossary
  has_many :meanings

  def meanings_or_new
    meanings.empty? ? [Meaning.new] : meanings
  end
end
