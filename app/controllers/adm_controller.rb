class AdmController < OfficeBaseController
    def index
        authorize @context, :can_admin?
        #@context.appointments.destroy_all
        @appointments = @context.appointments.map{|r| r}
    end

private
    def set_role
        @user_role = :admin
    end
end
