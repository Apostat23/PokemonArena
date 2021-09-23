# frozen_string_literal: true

RSpec.describe Arena do
  describe Arena::Pokemon do
    before :example do
      # url to pokeapi.co 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20' to set custom offset and limit,
      # default url on the class sends the first 20 items; @data must be equal to @@data from Arena::Pokemon *
      @data = JSON.parse RestClient.get 'https://pokeapi.co/api/v2/pokemon'
      @names = Array.new and @urls = Array.new
      @data["results"].each {|result| @names.push result["name"] and @urls.push result["url"]}
      @list = Hash.new and @data["results"].each {|r| @list.store(r["name"], JSON.parse(RestClient.get(r["url"])))}
      @class_list = subject.list and @class_data = subject.data and @class_names = Array.new and @class_urls = Array.new
      @class_data["results"].each {|result| @class_names.push result["name"] and @class_urls.push result["url"]}
    end
    describe 'initialize' do
      it 'receives the right keys' do; expect(@class_data.keys).to eq @data.keys end
      it 'receives the right pokemon name list' do; expect(@class_names).to eq @names end
      it 'receives the right pokemon url list' do; expect(@class_urls).to eq @urls end
      it 'receives the right pokemon data' do
        expect(@list.keys).to eq @class_list.keys
        @list.keys.each {|element| expect(@class_list[element]).to eq @list[element]}
      end
    end
    describe 'methods' do
      Arena::Pokemon.new.info_tags.each do |it|
        it ".get_#{it}" do
          expect(subject.respond_to?("get_#{it}".to_sym)).to be true
          @names.each do |name| # <= Check @@info_tags when updating the below EXPLICIT methods.
            expect(subject.get_abilities name).to eq @list[name]["abilities"] if it == "abilities"
            expect(subject.get_base_experience name).to eq @list[name]["base_experience"] if it == "base_experience"
            expect(subject.get_forms name).to eq @list[name]["forms"] if it == "forms"
            expect(subject.get_game_indices name).to eq @list[name]["game_indices"] if it == "game_indices"
            expect(subject.get_height name).to eq @list[name]["height"] if it == "height"
            expect(subject.get_held_items name).to eq @list[name]["held_items"] if it == "held_items"
            expect(subject.get_id name).to eq @list[name]["id"] if it == "id"
            expect(subject.get_is_default name).to eq @list[name]["is_default"] if it == "is_default"
            if it == "location_area_encounters"
              expect(subject.get_location_area_encounters name).to eq @list[name]["location_area_encounters"]
            end
            expect(subject.get_moves name).to eq @list[name]["moves"] if it == "moves"
            expect(subject.get_name name).to eq @list[name]["name"] if it == "name"
            expect(subject.get_order name).to eq @list[name]["order"] if it == "order"
            expect(subject.get_past_types name).to eq @list[name]["past_types"] if it == "past_types"
            expect(subject.get_species name).to eq @list[name]["species"] if it == "species"
            expect(subject.get_sprites name).to eq @list[name]["sprites"] if it == "sprites"
            expect(subject.get_stats name).to eq @list[name]["stats"] if it == "stats"
            expect(subject.get_types name).to eq @list[name]["types"] if it == "types"
            expect(subject.get_weight name).to eq @list[name]["weight"] if it == "wheight"
          end
        end
      end
    end
  end
end
