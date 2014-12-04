module Codebreaker

  class Game
    
    def initialize
      @secret_code = ""
      @count = 0
      @hintcount = 0
      @hinted_num = 0
      values = ['1', '2', '3', '4', '5', '6']
      4.times do
        foo = rand(values.length)
        @secret_code << values[foo]
        values.delete_at(foo)
      end
    end
    
    def guessed?(value)
      @count += 1
      if @count <= 10
        values = value.to_s.split("").uniq
        code = @secret_code.to_s.split("")
        status = 0

        values.each do |bar| 
          code.each do |foo| 
            if bar.to_i == foo.to_i
              status += 1
            end
          end
        end
        
        out = "+" * status 
        out << "-" * (4 - status)
        if status == 4 && value.to_i == @secret_code.to_i
          return :win
        else
          return out
        end
      else
        return :game_over
      end
    end
  
    def hint!
      @hintcount += 1
        if @hintcount == 1
          @hinted_num = rand(3)
          @secret_code.to_s.split("")[@hinted_num]
        elsif @hintcount == 2
          foo = ["*", "*", "*", "*"]
          foo[@hinted_num] = @secret_code.to_s.split("")[@hinted_num]
          foo.join("")
        else
          :hints_over
        end
    end

  end

end

