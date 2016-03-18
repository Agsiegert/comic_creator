class Api::V1::PanelsController < ApplicationController
  respond_to :json

  def index
    respond_with Panel.all
  end

  def show
    respond_with Panel.find(params[:id])
  end

  def create
    panel = Panel.new(panel_params)
    if panel.save
      render json: panel, status: 201
    else
      render json: { errors: panel.errors }, status: 422
    end
  end

  def update
    panel = Panel.find(params[:id])
    if panel.update(panel_params)
      render json: panel, status: 200
    else
      render json: { errors: panel.errors }, status: 422
    end
  end

  def destroy
    panel = Panel.find(params[:id])
    panel.destroy
    head 204
  end

  private

    def panel_params
      params.require(:panel).permit(:comic_id, :caption, :image)
    end
end
