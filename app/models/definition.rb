class Definition < ActiveRecord::Base
  belongs_to :glossary
  has_many :meanings
end
