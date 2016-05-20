class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :check_required_params, only: [:create, :update]

  # GET /teams.json
  def index
    @teams = Team.ranks
    render json: {teams: @teams}
  end

  # GET /teams/1.json
  def show
    render json: {team: @team.api_attributes}
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.json { render json: {team: @team.api_attributes}, status: :created }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.json { render json: {team: @team.api_attributes}, status: :ok}
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find_by_id(params[:id])
      unless @team.present?
        render json: {error: "cant find team"}
      end
    end

    def check_required_params
      if params[:team].nil?
        render json: {error: "missing team params"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
