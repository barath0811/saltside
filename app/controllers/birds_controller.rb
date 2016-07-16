class BirdsController < ApplicationController
  before_action :set_bird, only: [:show, :destroy]

  # GET /birds
  # GET /birds.json
  def index
    @birds = Bird.where(visible: true)
    render json: @birds, status: 200
  end

  # GET /birds/1
  # GET /birds/1.json
  def show
    if !@bird.nil?
      render json: @bird
    else
      render json: "", status: 404
    end
  end

  # POST /birds
  # POST /birds.json
  def create
    begin
      @bird = Bird.new(bird_params)
      @bird.visible = false if @bird.visible.nil?
      @bird.added = Date.today
      @bird.continents = bird_params[:continents].uniq
      if @bird.save
        render json: @bird, status: :created, location: @bird
      else
        render json: @bird.errors, status: 400
      end
    rescue Exception => e
      render json: "", status: 400
    end
  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    if !@bird.nil?
      @bird.destroy
      render json: "", status: 200
    else
      render json: "", status: 404
    end
  end

  private

    def set_bird
      @bird = Bird.where(id: params[:id]).first
    end

    def bird_params
      params.permit(:name, :family, :added, :visible, :continents => [])
    end
end
