#class SubmissionsController < ApplicationController
class SubmissionsController < OfficeSubmissionsController
#  before_action :set_submission, only: [:show, :edit, :update, :destroy]
#  before_action :set_context, only: [:index, :new, :create]
#  before_action :authenticate_user!
  
#  before_action :set_breadcrumbs

#  before_action -> { add_breadcrumb "Author", context_submissions_path(@context) }

  # GET /submissions
  # GET /submissions.json
  def index
#    @submissions = Submission.all
    @submissions = current_user.submissions.where(context: @context)
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
##    @context = @submission.context
##    add_breadcrumb @context.title, context_path(@context)
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
#    @submissions = @context.submissions.new
  end

  # GET /submissions/1/edit
  def edit
#    @context = @submission.context
    @submission_revision = @submission.last_created_revision
    @file_records = (true and @submission_revision) ? %w[author_file author_expert_file].map do |type|
      @submission_revision.get_or_new_file_by_type type
    end : []
  end

  # POST /submissions
  # POST /submissions.json
  def create
      data = submission_params.merge user: current_user
      @submission = @context.submissions.new(data)

#      if @submission.save
#        flash[:notice] = 'Submission was successfully created.'
#        @submission.sm_init!
#        respond_with(@journal_submission, location: edit_submission_path(@submission))
#      else
#        respond_with(@journal_submission)
#      end

#    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        @submission.sm_init!
        format.html { redirect_to edit_submission_path(@submission), notice: 'Submission was successfully created.' }
#        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    @submission_revision = @submission.last_created_revision
      data = submission_params
      if data
#        @journal_submission.update_draft(data)
        @submission.sm_update!(data)
        @file_records = @submission_revision ? %w[author_file author_expert_file].map do |type|
          @submission_revision.get_or_new_file_by_type type
        end : []
        #puts @file_records.inspect
      end

      case params[:op]
      when 'submit'
#        @journal_submission.submit_paper
        @submission.sm_submit! # '1234567'
      when 'revise'
#        @journal_submission.unsubmit_paper
        @submission.sm_revise!
      end

    respond_to do |format|
#      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
#      else
#        format.html { render :edit }
#        format.json { render json: @submission.errors, status: :unprocessable_entity }
#      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to context_submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
=begin
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
      @context = @submission.context
    end
    def set_context
      @context = Context.find(params[:context_id])
    end
    def set_breadcrumbs
      add_breadcrumb @context.title, context_path(@context)
#      add_breadcrumb "Author", context_submissions_path(@context), dropdown: {
      add_breadcrumb "My Papers", context_submissions_path(@context), dropdown: {
        list: [
#          {name: :a, text: 'Author', path: context_submissions_path(@context), active: true},
          {name: :a, text: 'My Papers', path: context_submissions_path(@context), active: true},
          {name: :ce, text: 'Chief Editor', path: context_ce_submissions_path(@context)},
#          {name: :e, text: 'Editor', path: '/editor'},
          {name: :r, text: 'Reviewer', path: '/reviewer'},
        ]
      }
      add_breadcrumb @submission.title, submission_path(@submission) if @submission
    end
=end

    def set_role
        @user_role = :a
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:title, :abstract, :sid, :user_id, :context_id, :revision_seq, :last_created_revision_id, :last_submitted_revision_id, :aasm_state) rescue nil
    end
end


