class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  before_action :check_required_params, only: [:create, :update]


  # GET /runs.json
  def index
    @runs = Run.all.includes(:player)
    render json: {runs: @runs.map{ |run| run.api_attributes}}
  end

  # GET /runs/1.json
  def show
    render json: {run: @run.api_attributes}
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  def edit
  end

  # POST /runs.json
  def create
    @run = Run.new(run_params)

    respond_to do |format|
      if @run.save
        format.json { render json: {run: @run.api_attributes}, status: :created}
      else
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1.json
  def update
    respond_to do |format|
      if @run.update(run_params)
        format.json { render json: {run: @run.api_attributes}, status: :ok }
      else
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1.json
  def destroy
    @run.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find_by_id(params[:id])
      unless @run.present?
        render json: {error: "cant find run"}
      end
    end

    def check_required_params
      if params[:run].nil?
        render json: {error: "missing run params"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(:player_id, :game_id)
    end
end
