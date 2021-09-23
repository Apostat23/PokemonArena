# app/api/v1/pokemons_controller.rb

class Api::V1::PokemonsController < ApplicationController
  before_action :set_pokemon

  def show; end

  private

    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end
end
