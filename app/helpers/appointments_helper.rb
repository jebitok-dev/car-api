module AppointmentsHelper
  def appointment_params
    params.require(:appointment).permit(:name, :model, :date, :city, :user_id)
  end
end
