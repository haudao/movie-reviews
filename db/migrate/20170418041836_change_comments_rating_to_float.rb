class ChangeCommentsRatingToFloat < ActiveRecord::Migration
  def change
    change_column :comments, :rating, :float
  end
end
