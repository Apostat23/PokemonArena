require 'arena'

class StartController < ApplicationController
  before_action :get_pokemon

  def get_pokemon
    params[:url].present? ? @pokemon = Arena::Pokemon.new(url: params[:url]) : @pokemon = Arena::Pokemon.new
    @data = @pokemon.data; @list = @pokemon.list; @info_tags = @pokemon.info_tags
  end

  def index
  end

  def pokemon
  end

  def _menu
  end

  def _top
  end

  def _bottom
  end
end
