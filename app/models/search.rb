class Search < ApplicationRecord
  belongs_to :user

  before_validation :downcase_query
  after_commit :delete_intermediate_searches, on: :create
  validates :query, presence: :true

  private

  def downcase_query
    query&.downcase!
  end

  def delete_intermediate_searches
    previous_search = user.searches[-2]
    new_search = user.searches[-1]
    return unless previous_search

    if previous_search.is_subset_of? new_search
      previous_search.destroy
    elsif new_search.is_subset_of? previous_search
      new_search.destroy
    end
  end

  protected

  def is_subset_of?(other_search)
    other_search.query.delete(' ').start_with? query.delete(' ')
  end
end
