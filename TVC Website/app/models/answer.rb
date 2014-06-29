class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def self.create_answer(the_column, value)
    the_answer = Answer.new
    the_answer.question = the_column.question
    if the_answer.question.open_or_not
      the_answer.answer = value
      the_answer.choice_id = 0
    else
      the_answer.choice_id = Choice.find_by_question_id_and_body(the_column.question.id, value).id
    end
    return the_answer
  end
end
