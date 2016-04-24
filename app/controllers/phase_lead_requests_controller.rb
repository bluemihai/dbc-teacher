class PhaseLeadRequestsController < ApplicationController
  before_action :set_phase_lead_request, only: [:show, :edit, :update, :destroy]

  def index
    @mon = params[:mon]
    if params[:mon] == 'all'
      @requests = PhaseDay::POTENTIAL_STARTS.map do |mon|
        PhaseLeadRequest.data_for_mon(@mon)
      end.flatten
      #TODO troubleshot and complete
    else
      if params[:mon]
        @mon = Date.iso8601(params[:mon])
      else
        @mon = PhaseDay.next_starting_monday
      end
      @requests = PhaseLeadRequest.data_for_mon(@mon)
    end
  end

  def show
  end

  def new
    @phase_lead_request = PhaseLeadRequest.new(
      teacher_id: current_user.id,
      phase_day_id: params[:phase_day_id]
    )
  end

  def edit
  end

  def create
    @phase_lead_request = PhaseLeadRequest.new(phase_lead_request_params)

    respond_to do |format|
      if @phase_lead_request.save
        format.html { redirect_to safe_back(phase_days_path), notice: 'Phase lead request was successfully created.' }
        format.json { render :show, status: :created, location: @phase_lead_request }
      else
        format.html { render :new }
        format.json { render json: @phase_lead_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phase_lead_request.update(phase_lead_request_params)
        format.html { redirect_to @phase_lead_request, notice: 'Phase lead request was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_lead_request }
      else
        format.html { render :edit }
        format.json { render json: @phase_lead_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phase_lead_request.destroy
    respond_to do |format|
      format.html { redirect_to phase_lead_requests_url, notice: 'Phase lead request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_phase_lead_request
      @phase_lead_request = PhaseLeadRequest.find(params[:id])
    end

    def phase_lead_request_params
      params.require(:phase_lead_request).permit(:day, :teacher_id, :phase_day_id, :approved_by_coordinator)
    end
end
