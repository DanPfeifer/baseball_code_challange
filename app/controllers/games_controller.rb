class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :check_required_params, only: [:create, :update]

  # GET /games.json
  def index
    @games = Game.all
    render json: {games: @games.map{ |game| game.api_attributes}}
  end


  # GET /games/1.json
  def show
    render json: {game: @game.api_attributes}
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.json { render json: {game: @game.api_attributes}, status: :created }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.json { render json: {game: @game.api_attributes}, status: :ok }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find_by_id(params[:id])
      unless @game.present?
        render json: {error: "cant find game"}
      end
    end
    def check_required_params
      if params[:game].nil?
        render json: {error: "missing game params"}
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:home_team_id, :away_team_id)
    end
end
