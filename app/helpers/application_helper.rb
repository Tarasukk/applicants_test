module ApplicationHelper
  def highlight_search_term(value)
    return value if value.blank? || @results.blank?
  
    input_words = params[:query].split
    input_words.each do |word|
      escaped_word = Regexp.escape(word)
      value.gsub!(Regexp.new("(?i)#{escaped_word}"), "<span class='bg-warning'>#{word}</span>")
    end
    value.html_safe
  end
  
end
