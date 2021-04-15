class Search < ApplicationRecord
  belongs_to :user

  before_validation :downcase_query, :delete_intermediate_searches
  validates :query, presence: :true

  private

  def downcase_query
    query&.downcase!
  end

  # deletes previous search if intermediate
  def delete_intermediate_searches
    previous_search = user.searches.last
    return unless previous_search

    previous_search.destroy if String::Similarity.cosine(previous_search.query, query) > 0.70
  end
end
