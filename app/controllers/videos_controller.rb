class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos.json
  def index
    @videos = Video.all
    render json: {videos: @videos.map{ |video| video.api_attributes}}
  end

  # GET /videos/1.json
  def show
   render json: { video: @video.api_attributes}
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.json {  render json: {video: @video.api_attributes}, status: :created}
      else
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.json { render json: {video: @video.api_attributes}, status: :ok }
      else
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find_by_id(params[:id])
      unless @video.present?
        render json: {error: "cant find video"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:video, :player_id)
    end
end
