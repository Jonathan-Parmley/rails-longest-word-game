require 'json'
require 'open-uri'

class GamesController < ApplicationController
  attr_accessor :letters

  def new
    @letters = []
    10.times do
      i = ('a'..'z').to_a.sample
      @letters << i
    end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]

    check = []
    @word.each_char do |l|
      c = @letters.include?(l)
      check << c
    end

    check << call(@word)

    if check.include?(false)
      @result = "Sorry but #{@word} can't be made from the given letters"
    else
      @result = "Congrats #{@word} can be made from the given letters"
    end
  end

  # JS function or Ruby for api call

  def call(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    res = open(url).read
    check = JSON.parse(res)
    check["found"]
  end
end
