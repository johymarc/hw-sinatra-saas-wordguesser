class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses= ''
  end
  
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  
  def guess(input)
      unless input.nil?
          if input.match?(/[[:alpha:]]/)
              letter=input.downcase 
	      if @word.include? letter
		  unless  @guesses.include? letter
		  	@guesses+= letter 
		  else
		  	return false
		  end
	      else
		  unless  @wrong_guesses.include? letter
		  	@wrong_guesses+= letter 
		  else
		  	return false
		  end
	      end
	      return true
	  end
      end
      raise ArgumentError
      return false
  
  end
  
  
  def word_with_guesses()
  
  @current_word = ''
  
  @word.each_char {|n| 
  
  	if @guesses.include? n 
  		@current_word += n
  		
  	else
  		@current_word += '-'
  	end
  }
 
  return @current_word 
  
  end


  def check_win_or_lose()
  
      if word_with_guesses == @word
      	return :win
      elsif wrong_guesses.length >= 7
        return :lose
      else
        return :play
      end



  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
