class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @place = Place.find_by_id(params[:place_id])
    if params[:place_id].blank?
      @appointments = Appointment.all
    else 
      @appointments = Appointment.where("place_id = ?" ,params[:place_id])
    end

  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show

  end

  # GET /appointments/new
  def new
    @groups = Group.where("user_id = ? " , current_user.id ).all  #.collect{ |type| [type.id, type.name] }
    @place = Place.find_by_id(params[:place_id])
    if @groups.nil?
      redirect_to place_appointments_url(@place), notice: 'You should create a group first!'
    end
    @appointment = @place.appointments.new
  end

  # GET /appointments/1/edit
  def edit
  end
  #place_appointments_url(@place)
  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @place = Place.find_by_id(params[:place_id])
    @appointment.place= @place

    @groups = Group.where("user_id = ? " , current_user.id ).all  #.collect{ |type| [type.id, type.name] }

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to root_url , notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @id = @place.id
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to place_appointments_url(place_id: @id ), notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @place = @appointment.place
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to place_appointments_url(@place), notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @place = Place.find_by(params[:place_id])
      @appointment = Appointment.find(place_id: params[:place_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:place_id, :group_id, :app_date)
    end
end
