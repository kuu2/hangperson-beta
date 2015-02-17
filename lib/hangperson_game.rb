class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses, :play_count, :word_so_far, :message

  def initialize(guess_word)
  	@word = guess_word
  	@guesses = ''
  	@wrong_guesses = ''
  	@play_count = 0
  	@word_so_far = ' '
  end

  def guess(letter)
  	if letter.nil?
      begin
  		  raise ArgumentError, 'no value!'
      rescue 
        @message = "Invalid guess."
        return false
      end
  	end
  	if letter.empty?
      begin
  		  raise ArgumentError, 'empty guess!'
      rescue
        @message = "Invalid guess."
        return false
      end
  	end
  	if !!(letter =~ /[^a-z]/i)
      begin
  		  raise ArgumentError, 'not a letter!'
      rescue
        @message = "Invalid guess."
        return false
      end
  	end
  	if letter.nil?
      begin
  		  raise ArgumentError, 'no value!'
      rescue
        @message = "Invalid guess."
        return false
      end
  	end
  	unless (@guesses.downcase.include? letter.downcase) || (@wrong_guesses.downcase.include? letter.downcase)
  		if @word.downcase.include? letter.downcase
  			@guesses += letter
  			@word_so_far = @word.gsub(/[^#{guesses}]/i, "-")
  		else
  			@wrong_guesses += letter
        @play_count += 1
  		end
  		return true
  	else
      @message = "You have already used that letter."
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
