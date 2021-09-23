# frozen_string_literal: true

require_relative "arena/version"
require "rest-client"
require "json"

module Arena
  class Error < StandardError; end
  # Your code goes here...
  
  class Pokemon
    attr_accessor :data, :list, :info_tags and def initialize url: nil
      default = 'https://pokeapi.co/api/v2/pokemon'
      url.nil? ? @data = JSON.parse(RestClient.get(default)) : @data = JSON.parse(RestClient.get(url))
      @list = Hash.new and @data["results"].each {|r| @list.store(r["name"], JSON.parse(RestClient.get(r["url"])))}
      @info_tags = @list.first.last.keys # <= Check tags when updating methods in RSpec.
      @info_tags.each {|it| self.class.define_method("get_#{it}") {|pokemon, list| @list[pokemon][it]}}
    end
  end
end
