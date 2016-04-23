class PhaseDaysController < ApplicationController
  before_action :set_phase_day, only: [:show, :edit, :update, :destroy]

  def index
    @phase_days = PhaseDay.all
    @phase_1_days = PhaseDay.ph(1)
    @phase_2_days = PhaseDay.ph(2)
    @phase_3_days = PhaseDay.ph(3)
  end

  def show
  end

  def new
    @phase_day = PhaseDay.new
  end

  def edit
  end

  def create
    @phase_day = PhaseDay.new(phase_day_params)

    respond_to do |format|
      if @phase_day.save
        format.html {
          redirect_to @phase_day, notice: 'PhaseDay successfully created.' }
        format.json { render :show, status: :created, location: @phase_day }
      else
        format.html { render :new }
        format.json {
          render json: @phase_day.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phase_day.update(phase_day_params)
        format.html { redirect_to @phase_day, 
          notice: 'Phase day was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_day }
      else
        format.html { render :edit }
        format.json {
          render json: @phase_day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phase_day.destroy
    respond_to do |format|
      format.html {
        redirect_to phase_days_url, notice: 'PhaseDay successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_phase_day
      @phase_day = PhaseDay.find(params[:id])
    end

    def phase_day_params
      params.require(:phase_day).permit(
        :title, :phase_no, :day_no, :lead_required)
    end
end
