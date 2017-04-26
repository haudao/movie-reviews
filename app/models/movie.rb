require 'open-uri'

class Movie < ActiveRecord::Base
  has_many :comments

  validates_uniqueness_of :title

  def self.search(key_w)
    where('title ILIKE ?', "%#{key_w}%")
  end
end
