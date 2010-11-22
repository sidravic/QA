module CommentsHelper
  def find_question(comment)
    Question.find(comment.commentable_id)
  end

  def find_associated_object(comment)
    if comment.commentable_type == "Question"
      Question.find(comment.commentable_id)
    elsif comment.commentable_type == "Answer"
      Answer.find(comment.commentable_id)
    end
  end

  def get_update_action(comment)    
    associated_object = find_associated_object(comment)    
    return  question_comment_url(associated_object, comment) if associated_object.is_a? Question
    return  question_answer_comment_url(associated_object.question, associated_object, comment) if associated_object.instance_of? Answer
  end
end
