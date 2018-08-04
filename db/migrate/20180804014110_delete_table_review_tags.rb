class DeleteTableReviewTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :review_tags
  end
end
