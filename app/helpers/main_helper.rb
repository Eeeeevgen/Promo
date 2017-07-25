module MainHelper
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment, comment: comment) +
          (nested_comments.!empty? ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end
end
