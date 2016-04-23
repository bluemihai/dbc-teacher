class PhaseLeadRequestsController < ApplicationController
  before_action :set_phase_lead_request, only: [:show, :edit, :update, :destroy]

  # GET /phase_lead_requests
  # GET /phase_lead_requests.json
  def index
    @phase_lead_requests = PhaseLeadRequest.all
  end

  # GET /phase_lead_requests/1
  # GET /phase_lead_requests/1.json
  def show
  end

  # GET /phase_lead_requests/new
  def new
    @phase_lead_request = PhaseLeadRequest.new
  end

  # GET /phase_lead_requests/1/edit
  def edit
  end

  # POST /phase_lead_requests
  # POST /phase_lead_requests.json
  def create
    @phase_lead_request = PhaseLeadRequest.new(phase_lead_request_params)

    respond_to do |format|
      if @phase_lead_request.save
        format.html { redirect_to @phase_lead_request, notice: 'Phase lead request was successfully created.' }
        format.json { render :show, status: :created, location: @phase_lead_request }
      else
        format.html { render :new }
        format.json { render json: @phase_lead_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phase_lead_requests/1
  # PATCH/PUT /phase_lead_requests/1.json
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

  # DELETE /phase_lead_requests/1
  # DELETE /phase_lead_requests/1.json
  def destroy
    @phase_lead_request.destroy
    respond_to do |format|
      format.html { redirect_to phase_lead_requests_url, notice: 'Phase lead request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase_lead_request
      @phase_lead_request = PhaseLeadRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_lead_request_params
      params.require(:phase_lead_request).permit(:day, :teacher_id, :phase_day_id, :approved_by_coordinator)
    end
end
