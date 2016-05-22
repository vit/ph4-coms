class RSubmissionsController < OfficeSubmissionsController
#	before_action -> { @section_journal_journals = true }
	before_action -> { @section_journal_reviewer_office = true }


	def index
        authorize @context, :can_reviewer?
		#@journal_submissions = @journal.submissions
#		@submissions = @context.submissions.all_submitted
		@submissions = @context.user_reviewer_invitations(current_user)
#		respond_with(@journal_submissions)
	end



private

#    def set_journal_only
#      #@journal = Journal::Journal.find(params[:journal_id])
#    end

    def set_role
        @user_role = :reviewer
    end

end
