class PhaseDaysController < ApplicationController
  before_action :set_phase_day, only: [:show, :edit, :update, :destroy]

  # GET /phase_days
  # GET /phase_days.json
  def index
    @phase_days = PhaseDay.all
  end

  # GET /phase_days/1
  # GET /phase_days/1.json
  def show
  end

  # GET /phase_days/new
  def new
    @phase_day = PhaseDay.new
  end

  # GET /phase_days/1/edit
  def edit
  end

  # POST /phase_days
  # POST /phase_days.json
  def create
    @phase_day = PhaseDay.new(phase_day_params)

    respond_to do |format|
      if @phase_day.save
        format.html { redirect_to @phase_day, notice: 'Phase day was successfully created.' }
        format.json { render :show, status: :created, location: @phase_day }
      else
        format.html { render :new }
        format.json { render json: @phase_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phase_days/1
  # PATCH/PUT /phase_days/1.json
  def update
    respond_to do |format|
      if @phase_day.update(phase_day_params)
        format.html { redirect_to @phase_day, notice: 'Phase day was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_day }
      else
        format.html { render :edit }
        format.json { render json: @phase_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phase_days/1
  # DELETE /phase_days/1.json
  def destroy
    @phase_day.destroy
    respond_to do |format|
      format.html { redirect_to phase_days_url, notice: 'Phase day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase_day
      @phase_day = PhaseDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_day_params
      params.require(:phase_day).permit(:title, :phase_no, :day_no, :lead_required)
    end
end
