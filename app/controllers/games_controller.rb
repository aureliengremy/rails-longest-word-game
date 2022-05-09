require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    # @letters = ['H','E','L','L','O']
    # @startTime = DateTime.now
  end

  def score
    # raise
    @win = false
    @word = params[:word].upcase
    @game_letters = params[:gameLetters].strip
    # @start_time = params[:startTime]

    english = english_word?(@word)
    included = included?(@word, @game_letters)
    if english
      if included
        # @finish = ((DateTime.now - @startTime) * 24 * 3600).to_i
        @score = 'Your word is in english and included the letters'
        @win = true;
      else
        @score = 'your word did\'t included the letters'
      end
    else
      @score = 'Your word is not in english'
    end
  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(answer, letters)
    answer.chars.all? do |letter|
      answer.count(letter) <= letters.count(letter)
    end
  end

  def time
    start = Time.now
  end
end
