class Comment < ActiveRecord::Base
  belongs_to :movie

  validates_presence_of :rating
end
