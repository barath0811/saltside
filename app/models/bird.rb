class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: Date
  field :visible, type: Boolean

  validates :name, presence: true, allow_blank: false
  validates :family, presence: true, allow_blank: false
  validates :continents, length: { minimum: 1 }

end
