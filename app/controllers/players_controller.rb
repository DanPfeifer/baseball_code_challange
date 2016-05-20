class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :player_card, :images, :videos, :highlights]
  before_action :check_required_params, only: [:create, :update]

  # GET /players.json
  def index
    # players are orderd by top scoring players
    # could add a filter param to get players ordered by team rank and then runs
    @players = Player.all.order("runs_count DESC")
    render json: {players: @players.map{ |player| player.api_attributes}}
  end

  # GET /players/1.json
  def show
    render json: {player: @player.api_attributes}
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.json { render json: { player: @player.api_attributes} , status: :created}
      else
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.json { render json: { player: @player.api_attributes}, status: :ok }
      else
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def player_card
    #all player media
    render json: {player: @player.api_attributes, videos: @player.videos.map{|video| video.api_attributes}, images: @player.images.map{|image| image.api_attributes}}
  end
  def images
    #all player photos
    render json: {player: @player.api_attributes, images: @player.images.map{|image| image.api_attributes}}
  end
  def videos
    #all player videos
    render json: {player: @player.api_attributes, videos: @player.videos.map{|video| video.api_attributes}}
  end
  def highlights
    # highlight video
    render json: {player: @player.api_attributes, highlight: @player.highlight.api_attributes}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find_by_id(params[:id])
      unless @player.present?
        render json: {error: "cant find player"}
      end
    end

    def check_required_params
      if params[:player].nil?
        render json: {error: "missing player params"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :team_id)
    end
end
