class Article < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_with_text, against: [:title, :body]

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
end
