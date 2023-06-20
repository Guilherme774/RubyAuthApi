class MusicsController < ApplicationController
  before_action :authorize
  before_action :set_music, only: %i[ show update destroy ]

  def index
    @musics = @user.musics.all

    render json: @musics
  end

  def show
    render json: @music
  end

  def create
    @music = Music.new(music_params.merge(user: @user))

    if @music.save
      render json: @music, status: :created, location: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @music.destroy
  end


  private

    def set_music
      @music = Music.find(params[:id])
    end

    def music_params
      params.require(:music).permit(:name)
    end
end
