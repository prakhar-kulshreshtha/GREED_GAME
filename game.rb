require './player'
require './turn'
class Game
  #valriables
  #1 player onboard
  # calculate score (player)
  # round
  attr_accessor :players
  def initialize
    @players = Array.new
    @final_round = false
    @player_to_reach_3000_first = nil
    @final_scores = {}

  end

  def start_game(number_of_player)
    number_of_player.times do |x|
      temp = Player.new("Player#{x+1}")
      @players.push(temp)
    end

    @players.each do |player|
      player.details

    end

    count = 5
    while !@final_round

      @players.each do |player|
        start_new_turn(player)

      end
    end
    puts "*********************************"
    puts "player to reach 3000 first is : #{@player_to_reach_3000_first.name}"
    puts "*********************************"
    @final_scores[@player_to_reach_3000_first.name.to_s] = @player_to_reach_3000_first.total_score


    #final round
    @players.each do |player|
      if player == @player_to_reach_3000_first
        next
      end
      start_new_turn(player)
      @final_scores[player.name.to_s] = player.total_score
    end

    puts "final scores : #{@final_scores} "
    puts "*********************************"
    puts "Winner is : #{largest_hash_key(@final_scores)} "
    puts "*********************************"


  end

  def start_new_turn(player)
    turn = Turn.new (player)
    puts "__________________________________________\n"
    puts "#{player.name} dice :  #{turn.dice}"
    score = turn.calculate_score2(turn.dice)
    if score >= 350
      player.game_started = true
    end
    puts "Turn score for #{player.name} : #{score}"
    if player.game_started
      player.update_score(score)
      puts "#{player.name} total score : #{player.total_score}"
      if player.total_score >=3000 && @final_round == false
        @final_round = true
        @player_to_reach_3000_first = player
      end
    else
      puts "#{player.name} needs 350 score to start"
    end
    puts "__________________________________________"
  end

  def largest_hash_key(hash)
    hash.max_by{|k,v| v}
  end
end