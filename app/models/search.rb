class QueryValidator < ActiveModel::Validator
  def validate(record)
    previous_search = record.user.searches.last
    return unless previous_search

    record.errors.add :query, 'is an intermediate search' if previous_search.intermediate_search? record
  end
end

class Search < ApplicationRecord
  belongs_to :user

  before_save :downcase_query
  before_create :delete_intermediate_searches

  include ActiveModel::Validations
  validates_with QueryValidator
  validates :query, presence: :true

  def intermediate_search?(other_search)
    query&.delete(' ')&.start_with? other_search&.query&.delete(' ')
  end

  private

  def downcase_query
    query.downcase!
  end

  # deletes previous search if new query starts with previous query
  def delete_intermediate_searches
    previous_search = user.searches.last
    return unless previous_search

    previous_search.destroy if intermediate_search? previous_search
  end
end
