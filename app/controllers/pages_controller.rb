class PagesController < ApplicationController

  def game
    @start = Time.now.to_i
    @grid = generate_grid(9)

  end

  def score
    @result = params[:aword]
    @grid = params[:grid]
    @end = Time.now.to_i
    @newstart = params[:start].to_i
    @newresult = []
    @arraygrid = []
    @arraygrid << @grid
    if included?(@result, @grid) && english_word?(@result)
      @newresult << @result
      @time_taken = @end - @newstart
      @score = compute_score(@newresult, @time_taken)
    else
      @score = "Try again bitch"
    end
  end

  private

  def generate_grid(x)
    grid = []
    x.times do
      grid << ('A'..'Z').to_a.sample
    end
    grid
  end

  def included?(guess, grid)
    guess.chars.all? { |word| guess.count(word) <= grid.count(word) }
  end

  def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * (100 - time_taken / 60.0)
  end

  # def run_game(attempt, grid, start_time, end_time)
  #   result = { time: end_time - start_time }

  #   score_and_message = score_and_message(attempt, grid, result[:time])
  #   result[:score] = score_and_message.first
  #   result[:message] = score_and_message.last

  #   result
  # end

  # def score_and_message(attempt, grid, time)
  #   if included?(attempt.upcase, grid)
  #     if english_word?(attempt)
  #       score = compute_score(attempt, time)
  #       [score, "well done"]
  #     else
  #       [0, "not an english word"]
  #     end
  #   else
  #     [0, "not in the grid"]
  #   end
  # end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
