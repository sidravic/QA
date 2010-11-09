module CommentsHelper
  def find_question(comment)
    Question.find(comment.commentable_id)
  end
end
