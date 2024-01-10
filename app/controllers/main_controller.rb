# frozen_string_literal: true

require_relative '../services/search_service'

class MainController < ApplicationController
  before_action :load_data, only: [:search]
  helper :all

  def index
    @results ||= Array.new(0)
  end

  def search
    @input_name = params[:query]
    search_service = SearchService.new(@data, @input_name)
    @results = search_service.perform_search
    render 'index'
  end

  private

  def load_data
    file_path = Rails.root.join('public', 'data.json')
    @data = JSON.parse(File.read(file_path))
  end
end
