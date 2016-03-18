class Api::V1::ComicsController < ApplicationController
  respond_to :json

  def index
    @comics = Comic.all
    # respond_with Comic.all
  end

  def show
    respond_with Comic.find(params[:id])
  end

  def create
    @comic = Comic.new(comic_params)

    if comic.save
      if params[:images]
        params[:images].each_with_index do |image, index|
          comic.panels.create(image: image, image_index: index)
        end
      end
      render json: comic, status: 201
    else
      render json: { errors: comic.errors }, status: 422
    end
  end

  def update
    @comic = Comic.find(params[:id])

    if comic.update(comic_params)
      if params[:images]
        params[:images].each_with_index do |image, index|
          comic.panels.create(image: image, image_index: index)
        end
      end
      render json: comic, status: 200
    else
      render json: { errors: comic.errors }, status: 422
    end
  end

  def destroy
    comic = Comic.find(params[:id])
    comic.destroy
    head 204
  end

  private

    def comic_params
      params.require(:comic).permit(:title)
    end
end
