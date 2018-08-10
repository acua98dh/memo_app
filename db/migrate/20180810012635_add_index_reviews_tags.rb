class AddIndexReviewsTags < ActiveRecord::Migration[5.2]
  def change
    add_index :reviews_tags, [:review_id, :tag_id],unique: true
  end
end
