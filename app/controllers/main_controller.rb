class MainController < ApplicationController
  before_action :load_data, only: [:search]
  helper :all

  def index
    @results ||= []
  end

  def search
    @input_name = params[:query]
    input_words = @input_name.split

    negative_terms = input_words.select { |term| term.start_with?('-') }.map { |term| term[1..-1] }
    positive_terms = input_words.reject { |term| term.start_with?('-') }

    @results = @data.select do |entry|
      entry_values = [entry["Name"], entry["Type"], entry["Designed by"]].compact
      positive_match = positive_terms.all? do |term|
        entry_values.any? { |value| value && value.downcase.include?(term.downcase) }
      end
      negative_match = negative_terms.none? do |term|
        entry_values.any? { |value| value && value.downcase.include?(term.downcase) }
      end
      positive_match && negative_match
    end

    sort_results_by_priority

    render 'index'
  end

  private

  def load_data
    file_path = Rails.root.join('public', 'data.json')
    @data = JSON.parse(File.read(file_path))
  end

  def sort_results_by_priority
    @results.sort_by! do |item|
      [
        item["Name"].downcase.include?(@input_name.downcase) ? 0 : 1,
        item["Name"].downcase
      ]
    end
  end
end
