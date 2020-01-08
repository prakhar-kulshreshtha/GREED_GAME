class Turn

  attr_accessor :turn_score
  def initialize(player)
    @player = player
    @turn_score = 0
    @dice = create_dice(5)
    @last_attempt = true
  end

  def start
    puts "round started for #{@player}"
  end

  def create_dice (num)
    d = []
    num.times do
      d.push (1+rand(6))
    end
    d
  end

  def dice
    @dice
  end

  def calculate_score2(dice)
    puts "calculate called with #{dice} turnscore #{@turn_score}"

    dice.each do |num|
      count = dice.count(num)
      if count >= 3
        if num ==1
          @turn_score+=1000 + (count-3)*100
        elsif num ==5
          @turn_score +=500 + (count-3)*50
        else
          @turn_score+= num*100
        end
      elsif count > 0 && count<3
        if num==1
          @turn_score+=count*100
        elsif num==5
          @turn_score+= count*50
        else
          next
        end
      end
      count.times{
        dice.delete(num)
      }
    end
    @dice = dice
    if dice.size >1
      dice =create_dice(dice.size)
      calculate_score2(dice)
    elsif dice.size ==1 && @last_attempt
      #puts "calculating last attempt"
      dice =create_dice(1)
      @last_attempt = false
      calculate_score2(dice)

    else
      puts "turn finished"
    end
    return @turn_score
  end

  def turn_score
    @turn_score
  end

end