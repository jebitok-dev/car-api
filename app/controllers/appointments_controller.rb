class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include AppointmentsHelper

  def index
    @appointments = Appointment.all
    render json: @appointments
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.save

    render json: { success: 'An appointment was succesfully added!' }
  end
end
