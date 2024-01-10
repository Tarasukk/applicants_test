# frozen_string_literal: true

module ApplicationHelper
  def highlight_search_term(value)
    # Have a bug. For example, input_words = 'Ba', then in the text 'bash' will be replaced by 'Bash', and 'BASIC' by 'BaSIC'. But only visually it does not affect the data
    return value if value.blank? || @results.blank?

    input_words = params[:query].split
    input_words.each do |word|
      escaped_word = Regexp.escape(word)
      value.gsub!(Regexp.new("(?i)#{escaped_word}"), "<span class='bg-warning'>#{word}</span>")
    end
    value.html_safe
  end
end
