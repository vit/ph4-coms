class ContextAppointmentsController < OfficeBaseController
    def index
    end

    def create
        authorize @context, :can_admin?
        data = appointment_params
        data[:user] = User.r_find(data[:user])
        #puts data
#        @appointment = @context.appointments.new(data)
        @appointment = @context.appointments.create(data) rescue nil
        #puts @appointment
#        @appointment.save rescue @appointment.destroy
        @appointment.save if @appointment
        @appointments = @context.appointments.map{|r| r}
        respond_to do |format|
#            format.js { render partial: 'refresh_ce_list.js.erb' }
            format.js { render 'refresh_ce_list.js.erb' }
        end

#        respond_to do |format|
#            if @appointment.save
#                format.js { render partial: 'refresh_ce_list.js.erb' }
#            else
#                format.js
#            end
#        end
    end
    def destroy
        authorize @context, :can_admin?
#        @appointment = @context.appointments.find(params['id'])
        #puts @appointment
        @appointment.destroy
        @appointments = @context.appointments.map{|r| r}
        respond_to do |format|
            format.js { render 'refresh_ce_list.js.erb' }
        end
    end

private
    def set_role
        @user_role = :admin
    end
    def appointment_params
      params.require(:context_appointment).permit(:role_name, :user) rescue nil
    end

    def set_context_indirect
        @appointment = ContextAppointment.find(params[:id])
        @context = @appointment.context
    end

end
