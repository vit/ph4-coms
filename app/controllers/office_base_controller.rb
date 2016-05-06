class OfficeBaseController < ApplicationController

	before_action :set_role

#    before_action :set_context, only: [:index, :new, :create]
    before_action :set_context

    before_action :authenticate_user!
    before_action :set_breadcrumbs
#    after_action :set_breadcrumbs

private

    def set_context
      @context = Context.find(params[:context_id]) if params[:context_id]
      set_context_indirect unless @context
    end

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

end
