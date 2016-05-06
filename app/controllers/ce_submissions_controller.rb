#class Journal::CeSubmissionsController < Journal::BaseController
class CeSubmissionsController < Journal::OfficeSubmissionsController
#	before_action -> { @section_journal_journals = true }
	before_action -> { @section_journal_chief_editor_office = true }


	def index
		#@journal_submissions = @journal.submissions
		@submissions = @context.submissions.all_submitted
#		respond_with(@journal_submissions)
	end



private

    def set_journal_only
      #@journal = Journal::Journal.find(params[:journal_id])
    end

#protected
    def set_role
        @user_role = :ce
    end

end
