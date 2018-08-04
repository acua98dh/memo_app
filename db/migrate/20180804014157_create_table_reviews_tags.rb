class CreateTableReviewsTags < ActiveRecord::Migration[5.2]
  def change
    create_join_table :reviews, :tags
  end
end
