#class OfficeSubmissionsController < ApplicationController
class OfficeSubmissionsController < OfficeBaseController
	before_action -> { @section_journal_journals = true }
#	before_action -> { @section_journal_chief_editor_office = true }

#	before_action :set_role


#  before_action :set_submission, only: [:show, :edit, :update, :destroy]
#  before_action :set_context, only: [:index, :new, :create]

#  before_action :authenticate_user!
#  before_action :set_breadcrumbs

#  respond_to :html, :js

	def show
		@revision = @submission.last_submitted_revision
		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
#		@my_invite = @submission.user_invite current_user
		@my_review = @revision.user_review(current_user) || @revision.reviews.build(user: current_user)

	end

	def update
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
#		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
		@decision = @revision.revision_decision
		@my_invite = @submission.user_invite current_user
		@my_review = @revision.user_review current_user


		data = params[:journal_revision_decision]
		if data
			data = data.permit(:decision, :comment).merge user: current_user
			if @decision
		        @decision.sm_update!(data)
			else
				@revision.sm_create_decision!(data)
				@decision = @revision.revision_decision
			end
		end

		data = params[:journal_review]
		if data
			data = data.permit(:decision, :comment).merge user: current_user
			if @my_review
		        @my_review.sm_update!(data)
			else
				@revision.sm_create_review!(data)
				@my_review = @revision.user_review current_user
			end
		end

		case params[:op]
		when 'submit_decision'
			@decision.sm_submit!
#		when 'cancel_decision'
#			@decision.sm_cancel!
		when 'add_reviewer_invites'
			r_ids = params[:reviewer_invites]
			r_ids.each do |r_id|
				puts r_id
				u = User.find(r_id)
				#@submission.reviewer_invites.find(user: u)
				inv = @submission.reviewer_invites.build(user: u)
				inv.save! rescue nil
			end if r_ids and r_ids.is_a?(Array)
		when 'activate_reviewer_invite'
			r_id = params[:reviewer_id]
			u = User.find(r_id)
			inv = @submission.reviewer_invites.find_by(user: u)
			inv.sm_activate! if inv.may_sm_activate?
		when 'drop_reviewer_invite'
			r_id = params[:reviewer_id]
			u = User.find(r_id)
			inv = @submission.reviewer_invites.find_by(user: u)
			inv.sm_destroy! if inv.may_sm_destroy?
		when 'accept_my_reviewer_invite'
			@my_invite.sm_accept! if @my_invite && @my_invite.may_sm_accept?
		when 'decline_my_reviewer_invite'
			@my_invite.sm_decline! if @my_invite && @my_invite.may_sm_decline?
		when 'submit_my_review'
			@my_review.sm_submit! if @my_review && @my_review.may_sm_submit?
		end

		@decision.reload if @decision
		@revision.reload
		@submission.reload

		@decision = @revision.build_revision_decision({user: current_user}) unless @decision
		@my_review = @revision.reviews.build(user: current_user) unless @my_review


		respond_to do |format|
			format.js
		end
	end



private

    def set_submission
      @submission = Submission.find(params[:id])
      @context = @submission.context
    end

    def set_context_indirect
    	set_submission
    end

#    def set_context
#      @context = Context.find(params[:context_id])
#    end

=begin
    def set_breadcrumbs
#        puts "!!!!! "+@user_role+" !!!!!"
		list = [
#          {name: :a, text: 'My Papers', path: context_submissions_path(@context), active: true, role: :a},
          {name: :a, text: 'My Papers', path: context_submissions_path(@context), role: :a},
          {name: :ce, text: 'Chief Editor', path: context_ce_submissions_path(@context), role: :ce},
#          {name: :e, text: 'Editor', path: '/editor', role: :e},
#          {name: :r, text: 'Reviewer', path: '/reviewer', role: :r},
          {name: :r, text: 'Reviewer', path: context_r_submissions_path(@context), role: :r},
        ]
        current = list[0]
        list.each do |e|
			if e[:role]==@user_role
				e[:active] = true
		        current = e
			end
        end

      add_breadcrumb @context.title, context_path(@context)
#      add_breadcrumb "My Papers", context_submissions_path(@context), dropdown: {
      add_breadcrumb current[:text], current[:path], dropdown: {
      	list: list
      }
      add_breadcrumb @submission.title, submission_path(@submission) if @submission
    end
=end

end
