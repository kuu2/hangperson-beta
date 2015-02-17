class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses, :play_count, :word_so_far

  def initialize(guess_word)
  	@word = guess_word
  	@guesses = ''
  	@wrong_guesses = ''
  	@play_count = 0
  	@word_so_far = ''
  end

  def guess(letter)
  	if letter.nil?
  		raise ArgumentError, 'no value!'
  	end
  	if letter.empty?
  		raise ArgumentError, 'empty guess!'
  	end
  	if !!(letter =~ /[^a-z]/i)
  		raise ArgumentError, 'not a letter!'
  	end
  	if letter.nil?
  		raise ArgumentError, 'no value!'
  	end
  	unless (@guesses.include? letter) || (@wrong_guesses.include? letter)
  		if @word.include? letter
  			@guesses += letter
  			@word_so_far = @word.gsub(/[^#{guesses}]/, "-")
  		else
  			@wrong_guesses += letter
  		end
  		@play_count += 1
  		return true
  	else
  		return false
  	end
  end

  def word_with_guesses
  	unless @guesses.empty?
  		return @word_so_far
  	else
  		return @word.gsub(/./, "-")
  	end
  end

  def check_win_or_lose
  	if @word_so_far.eql? @word
  		return :win
  	elsif @play_count == 7
  		return :lose
  	else
  		return :play
  	end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
