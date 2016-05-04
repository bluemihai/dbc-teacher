class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Resource.order(:usefulness_rating).reverse
  end

  def show
  end

  def new
    @resource = Resource.new
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { 
          redirect_to @resource.phase_day || resources_path,
          notice: 'Resource was successfully created.'
        }
        format.json {
          render :show, status: :created, location: @resource }
      else
        format.html {
          render :new }
        format.json {
          render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html {
          redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json {
          render :show, status: :ok, location: @resource }
      else
        format.html {
          render :edit }
        format.json {
          render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    phase_day = @resource.phase_day
    @resource.destroy
    respond_to do |format|
      format.html {
        redirect_to phase_day || resources_url,
        notice: 'Resource successfully destroyed.'
      }
      format.json {
        head :no_content }
    end
  end

  private
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(
        :url,
        :phase_day_id,
        :source,
        :last_shared,
        :usefulness_rating,
        :name,
        :kind,
        :description
      )
    end
end
