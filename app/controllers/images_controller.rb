class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :check_required_params, only: [:create, :update]

  # GET /images.json
  def index
    @images = Image.all
    render json: {images: @images.map{ |image| image.api_attributes}}
  end

  # GET /images/1.json
  def show
    render json: {image: @image.api_attributes}
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.json { render json: {image: @image.api_attributes}, status: :created}
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.json { render json: {image: @image.api_attributes}, status: :ok }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find_by_id(params[:id])
      unless @image.present?
        render json: {error: "cant find images"}
      end
    end

    def check_required_params
      if params[:image].nil?
        render json: {error: "missing image params"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:image, :player_id)
    end
end
