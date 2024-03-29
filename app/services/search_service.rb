# frozen_string_literal: true

# app/services/search_service.rb
class SearchService
  def initialize(data, query)
    @data = data
    @query = query
  end

  def perform_search
    input_words = @query.split

    negative_terms = input_words.select { |term| term.start_with?('-') }.map { |term| term[1..] }
    positive_terms = input_words.reject { |term| term.start_with?('-') }

    results = @data.select do |entry|
      entry_values = [entry['Name'], entry['Type'], entry['Designed by']].compact
      positive_match = positive_terms.all? do |term|
        entry_values.any? { |value| value&.downcase&.include?(term.downcase) }
      end
      negative_match = negative_terms.none? do |term|
        entry_values.any? { |value| value&.downcase&.include?(term.downcase) }
      end
      positive_match && negative_match
    end

    sort_results_by_priority(results)
  end

  private

  def sort_results_by_priority(results)
    results.sort_by do |item|
      [
        item['Name'].downcase.include?(@query.downcase) ? 0 : 1,
        item['Name'].downcase
      ]
    end
  end
end
