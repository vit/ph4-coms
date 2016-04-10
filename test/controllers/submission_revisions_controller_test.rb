require 'test_helper'

class SubmissionRevisionsControllerTest < ActionController::TestCase
  setup do
    @submission_revision = submission_revisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:submission_revisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create submission_revision" do
    assert_difference('SubmissionRevision.count') do
      post :create, submission_revision: { aasm_state: @submission_revision.aasm_state, revision_n: @submission_revision.revision_n, sid: @submission_revision.sid, submission_id: @submission_revision.submission_id }
    end

    assert_redirected_to submission_revision_path(assigns(:submission_revision))
  end

  test "should show submission_revision" do
    get :show, id: @submission_revision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @submission_revision
    assert_response :success
  end

  test "should update submission_revision" do
    patch :update, id: @submission_revision, submission_revision: { aasm_state: @submission_revision.aasm_state, revision_n: @submission_revision.revision_n, sid: @submission_revision.sid, submission_id: @submission_revision.submission_id }
    assert_redirected_to submission_revision_path(assigns(:submission_revision))
  end

  test "should destroy submission_revision" do
    assert_difference('SubmissionRevision.count', -1) do
      delete :destroy, id: @submission_revision
    end

    assert_redirected_to submission_revisions_path
  end
end
