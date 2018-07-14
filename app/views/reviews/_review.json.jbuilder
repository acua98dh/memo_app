json.extract! review, :id, :name, :rating, :review, :freq, :created_at, :updated_at
json.url review_url(review, format: :json)
