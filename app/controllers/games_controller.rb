require 'open-uri'
require 'json'


class GamesController < ApplicationController
  helper_method :score
  def new
    @letters = Array.new(10) {('A'..'Z').to_a.sample }.join(" ")
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_check = open(url).read
    @letters = params[:letters]
    json_hash = JSON.parse(word_check)
    if json_hash["found"]
      params[:word].upcase.chars.each do |character|
        if @letters.include?(character)
          @letters.delete(character)
          @score = "Congratulations! #{params[:word]} is a valid English word."
        else
          @score = "Sorry, but #{params[:word]} can't be built out of #{@letters}"
        end
      end
    else
      @score = "Sorry but #{params[:word]} does not seem to be a valid English word"
    end
  end
end

