class StartController < ApplicationController
  before_action :get_pokemon

  def get_pokemon
    params[:url].present? ? @request = get_data(params[:url]) : @request = get_data
  end

  attr_accessor :data, :list, :info_tags and def get_data url: nil
    default = 'https://pokeapi.co/api/v2/pokemon' and @data = JSON.parse(RestClient.get(url || default))
    @list = Hash.new and @data["results"].each {|r| @list.store(r["name"], JSON.parse(RestClient.get(r["url"])))}
    @info_tags = @list.first.last.keys # <= Check tags when updating methods in RSpec.
    @info_tags.each {|it| self.class.define_method("get_#{it}") {|pokemon, list| list[pokemon][it]}}
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
