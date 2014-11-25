module Codebreaker
  
  class Config
    @@actions = ['help', 'quit', 'hint']
     
    def self.actions 
      @@actions 
    end

  end  
  
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

    def start
      puts @secret_code
    end

    def launch!
      introduction
      result = nil
      until result == :quit
        action = get_action
        result = execute(action)
      end
    end

    def execute(action)
      case action
      when 'help'
        puts "I've got four digits. Try to find it ;) You can type hint to get a hint but only thrice"
      when 'hint'
        @hintcount += 1
        if @hintcount == 1
          @hinted_num = rand(3)
          puts "All right. I have \"" + @secret_code.split("")[@hinted_num] + "\" into my code"
        elsif @hintcount == 2
          foo = ["*", "*", "*", "*"]
          foo[@hinted_num] = @secret_code[@hinted_num]
          puts "Hint again? You're crazy! >>>" + foo.join("") + "<<< Don't you know what I mean?"
        end
      when 'quit'
        return :quit
      else
        if action.to_i >= 1
          resolt = check_value(action)
          return :quit if resolt == :quit
        end
      end

    end

    def check_value(value)
      @count += 1
      if @count <= 10
        values = value.to_s.split("")
        code = @secret_code.split("")
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
          conclusion("You win. The secret code is " + @secret_code.to_s + "!!!")
          :quit
        else
          puts out
        end
      else
        conclusion("You didn't break my code. I had " + @secret_code.to_s + " :)")
        :quit
      end

    
    end

    def get_action
      action = nil
      until Codebreaker::Config.actions.include?(action) || action.to_i >= 1
        puts "Actions: " + Codebreaker::Config.actions.join(", ") if action
        print "> "
        user_response = gets.chomp
        args = user_response.downcase.strip.split(' ')
        action = args.shift
      end
      return action
    end

    def introduction
      print "\n\n>>>Welcome to attractive game Codebreaker<<<\n\n"
    end

    def conclusion(message=nil)
      print "\n"
      puts message if message
      print "\n>>>Goodbye<<<\n\n"
    end

  end

end
