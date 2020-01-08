class Player
  attr_accessor :total_score , :name, :game_started
  def initialize(name)
    @name = name
    @total_score = 0
    @game_started = false
      #@dice = create_dice
  end

  def details
    puts "name : #{@name} score : #{@score}"
  end

  def total_score
    @total_score
  end

  def update_score(diff)
    @total_score+=diff
  end

  def game_started
    @game_started
  end








end