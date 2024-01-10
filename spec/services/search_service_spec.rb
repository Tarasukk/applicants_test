# spec/services/search_service_spec.rb
require 'rails_helper'

RSpec.describe SearchService do
  describe '#perform_search' do
    let(:data) do
      [
        { 'Name' => 'C#',
          'Type' => 'Compiled, Iterative, Object-oriented class-based, Procedural', 'Designed by' => 'Microsoft' },
        { 'Name' => 'F#', 'Type' => 'Interactive mode', 'Designed by' => 'Microsoft Research, Don Syme' },
        { 'Name' => 'Common Lisp', 'Type' => 'Compiled, Interactive mode, Object-oriented class-based, Reflective',
          'Designed by' => 'Scott Fahlman, Richard P. Gabriel, Dave Moon, Guy Steele, Dan Weinreb' },
        { 'Name' => 'BASIC', 'Type' => 'Imperative, Compiled, Procedural, Interactive mode, Interpreted',
          'Designed by' => 'John George Kemeny, Thomas Eugene Kurtz' },
        { 'Name' => 'Chapel', 'Type' => 'Array',
          'Designed by' => 'David Callahan, Hans Zima, Brad Chamberlain, John Plevyak' }
      ]
    end

    it 'returns the search results with the value reversed' do
      search_service = SearchService.new(data, 'Lisp Common')
      results = search_service.perform_search
      expect(results.size).to eq(1)
      expect(results.first['Name']).to eq('Common Lisp')
    end

    it 'return search results by designed by field' do
      search_service = SearchService.new(data, 'Microsoft')
      results = search_service.perform_search
      expect(results.size).to eq(2)
      expect(results.first['Designed by']).to eq('Microsoft')
    end

    it 'handles negative terms' do
      search_service = SearchService.new(data, 'john -array')
      results = search_service.perform_search
      expect(results.size).to eq(1)
      expect(results.first['Name']).to eq('BASIC')
    end
  end
end
