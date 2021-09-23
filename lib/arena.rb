# frozen_string_literal: true

require_relative "arena/version"
require 'rest-client'
require 'json'

module Arena
  class Error < StandardError; end
  # Your code goes here...
  
  class Pokemon
    # Example of url from pokeapi.co 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20', there are 1118
    # pokemons on database at sep/18/2021, @@data must be equal to @data from Arena::Pokemon on the RSpec. *
    @@data = JSON.parse RestClient.get 'https://pokeapi.co/api/v2/pokemon'
    @@list = Hash.new and @@data["results"].each {|r| @@list.store(r["name"], JSON.parse(RestClient.get(r["url"])))}
    @@info_tags = @@list.first.last.keys # <= Check tags when updating methods in RSpec.
    @@info_tags.each {|info_tag| define_method("get_#{info_tag}") {|pokemon, list| list[pokemon][info_tag]}}
    attr_accessor :data, :list, :info_tags and def initialize url: nil
      if url.nil?
        @data = @@data; @list = @@list; @info_tags = @@info_tags
      else
        @data = JSON.parse RestClient.get url
        @list = Hash.new and @data["results"].each {|r| @list.store(r["name"], JSON.parse(RestClient.get(r["url"])))}
        @info_tags = @list.first.last.keys
      end
    end
  end
end
