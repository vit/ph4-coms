class SubmissionRevisionsController < ApplicationController
  before_action :set_submission_revision, only: [:show, :edit, :update, :destroy]

  # GET /submission_revisions
  # GET /submission_revisions.json
  def index
    @submission_revisions = SubmissionRevision.all
  end

  # GET /submission_revisions/1
  # GET /submission_revisions/1.json
  def show
  end

  # GET /submission_revisions/new
  def new
    @submission_revision = SubmissionRevision.new
  end

  # GET /submission_revisions/1/edit
  def edit
  end

  # POST /submission_revisions
  # POST /submission_revisions.json
  def create
    @submission_revision = SubmissionRevision.new(submission_revision_params)

    respond_to do |format|
      if @submission_revision.save
        format.html { redirect_to @submission_revision, notice: 'Submission revision was successfully created.' }
        format.json { render :show, status: :created, location: @submission_revision }
      else
        format.html { render :new }
        format.json { render json: @submission_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submission_revisions/1
  # PATCH/PUT /submission_revisions/1.json
  def update
    respond_to do |format|
      if @submission_revision.update(submission_revision_params)
        format.html { redirect_to @submission_revision, notice: 'Submission revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission_revision }
      else
        format.html { render :edit }
        format.json { render json: @submission_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submission_revisions/1
  # DELETE /submission_revisions/1.json
  def destroy
    @submission_revision.destroy
    respond_to do |format|
      format.html { redirect_to submission_revisions_url, notice: 'Submission revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission_revision
      @submission_revision = SubmissionRevision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_revision_params
      params.require(:submission_revision).permit(:sid, :submission_id, :revision_n, :aasm_state)
    end
end
