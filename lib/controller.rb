require 'models'

# MarsRoversCLI acts as the controller of the application receiving user input,
# executing the business logic and outputing the results.
class MarsRoversCLI
  # Receives data input in terms of the Map and the Rover entities and executes
  # the instructions of each Rover instance, outputing the results.
  def self.execute
    # Initialize data store
    rovers_with_instructions = Array.new

    # Get data input
    map = get_map
    return unless map # Exit on erroneous input
    begin
      rover = get_rover
      rovers_with_instructions << [rover, get_rover_instructions] if rover
    end while rover # Allow arbritrary number of rover entities

    # Execute instructions on each rover and output results
    for rover_with_instructions in rovers_with_instructions
      rover = rover_with_instructions.first
      instructions = rover_with_instructions.last

      for instruction in instructions.to_s.split('') # In Ruby 1.9 use each_char
        case instruction
        when 'M' then rover.move
        when 'R', 'L' then rover.rotate(instruction == 'L')
        end
      end if instructions

      puts 'ROVER OUT OF MAP BOUNDS' unless rover.in_map?(map.width, map.height)
      puts '%d %d %s' % rover.position
    end
  end

  protected

  # Returns a Map instance based on width and height string input, or nil on
  # empty line. Invalid input requires repetition.
  def self.get_map
    # TODO: Refactor input and its validation
    until (input = gets) && (input =~ /(\d+)\s+(\d+)/)
      return nil if input.to_s.chomp.empty?
      puts "Invalid input"
    end
    Map.new($1.to_i, $2.to_i)
  end

  # Returns a Rover instance based on coordinates and heading string input, or
  # nil on empty line. Invalid input requires repetition.
  def self.get_rover
    # TODO: Refactor input and its validation
    until (input = gets) && (input =~ /(\d+)\s+(\d+)\s+([NESW])/i)
      return nil if input.to_s.chomp.empty?
      puts "Invalid input"
    end
    Rover.new($1.to_i, $2.to_i, $3.to_s.upcase)
  end

  # Returns a string of instructions based on input, or nil on empty line.
  # Invalid input requires repetition.
  def self.get_rover_instructions
    until (input = gets) && (input =~ /([RLM]+)/i)
      return nil if input.to_s.chomp.empty?
      puts "Invalid input"
    end
    return $1.to_s.upcase
  end
end
