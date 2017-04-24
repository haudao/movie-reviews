require 'open-uri'

class Movie < ActiveRecord::Base
  has_many :comments

  validates_uniqueness_of :title
end
