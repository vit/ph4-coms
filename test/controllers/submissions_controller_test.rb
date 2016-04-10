require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  setup do
    @submission = submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create submission" do
    assert_difference('Submission.count') do
      post :create, submission: { aasm_state: @submission.aasm_state, abstract: @submission.abstract, context_id: @submission.context_id, last_created_revision_id: @submission.last_created_revision_id, last_submitted_revision_id: @submission.last_submitted_revision_id, revision_seq: @submission.revision_seq, sid: @submission.sid, title: @submission.title, user_id: @submission.user_id }
    end

    assert_redirected_to submission_path(assigns(:submission))
  end

  test "should show submission" do
    get :show, id: @submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @submission
    assert_response :success
  end

  test "should update submission" do
    patch :update, id: @submission, submission: { aasm_state: @submission.aasm_state, abstract: @submission.abstract, context_id: @submission.context_id, last_created_revision_id: @submission.last_created_revision_id, last_submitted_revision_id: @submission.last_submitted_revision_id, revision_seq: @submission.revision_seq, sid: @submission.sid, title: @submission.title, user_id: @submission.user_id }
    assert_redirected_to submission_path(assigns(:submission))
  end

  test "should destroy submission" do
    assert_difference('Submission.count', -1) do
      delete :destroy, id: @submission
    end

    assert_redirected_to submissions_path
  end
end
