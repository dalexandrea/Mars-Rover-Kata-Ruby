# Map struct class represents the rectangle mapped area of a plateau on Mars,
# defined by its width and height properties.
class Map < Struct.new(:width, :height); end;

# Rover class represents the vehicle entity of a robotic rover to be landed by
# NASA on a plateau on Mars. It implements the actions the vehicle may do and
# reports its status.
class Rover
  HEADINGS = ['N', 'E', 'S', 'W'].freeze

  # Initialize entity properties
  attr_accessor :x, :y, :heading

  # The Rover entity is initialized by setting up landing position and heading.
  def initialize(x, y, heading)
    @x, @y, @heading = x, y, HEADINGS.find_index(heading)
  end

  # Move the vehicle one map square towards current heading by updating the
  # relevant position coordinate. The rover may find itself out of map bounds.
  def move
    case @heading
    when 0 then @y += 1 # Move towards North
    when 1 then @x += 1 # Move towards East
    when 2 then @y -= 1 # Move towards South
    when 3 then @x -= 1 # Move towards West
    end
  end

  # Rotate the vehicle clockwise or counter-clockwise depending on the first
  # argument by updating the heading property.
  def rotate(counterclockwise = false)
    if counterclockwise
      @heading == 0 ? @heading = 3 : @heading -= 1
    else
      @heading == 3 ? @heading = 0 : @heading += 1
    end
  end

  # Returns the vehicle current position and heading.
  def position
    [ @x, @y, Rover::HEADINGS[@heading] ]
  end
  
  # Returns true if the vehicle coordinates are within the rectangle defined by
  # the arguments width and height.
  def in_map?(width, height)
    @x.between?(0, width) && @y.between?(0, height)
  end
end
