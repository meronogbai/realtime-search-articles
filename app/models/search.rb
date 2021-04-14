class Search < ApplicationRecord
  belongs_to :user

  # Delete the previous search from the same user (identified by uuid)
  # if the new search query starts with the same text

  before_validation :to_lower, :delete_intermediate_searches

  private

  def to_lower
    query.downcase!
  end

  def delete_intermediate_searches
    prev_search = user.searches.last
    return unless prev_search

    prev_search.destroy if query.delete(' ').start_with? prev_search.query.delete(' ')
  end
end
