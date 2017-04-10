require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
    @poll = Poll.find @question.poll_id
  end

  test "should get index" do
    get poll_questions_path @poll
    assert_response :success
  end

  test "should get new" do
    get new_poll_question_path @poll
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post poll_questions_path(@poll), params: { question: { kind: @question.kind, poll_id: @question.poll_id, title: @question.title } }
    end

    assert_redirected_to @poll
  end

  test "should show question" do
    get poll_question_path @poll, @question
    assert_response :success
  end

  test "should get edit" do
    get edit_poll_question_path @poll, @question
    assert_response :success
  end

  test "should update question" do
    patch poll_question_path(@poll, @question), params: { question: { kind: @question.kind, poll_id: @question.poll_id, title: @question.title } }
    assert_redirected_to poll_question_path(@poll, @question)
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete poll_question_path(@poll, @question)
    end

    assert_redirected_to poll_questions_path
  end
end
