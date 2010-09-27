CLIColorize
--------

Description:

A simple Ruby module for use when colorizing output to the terminal.


Installation:

<sudo> gem install cli-colorize


Supported colors:
      :black
      :red
      :green
      :yellow
      :blue
      :magenta
      :cyan
      :white
      :default (use the console's default color)

Supported additional config options:
    :reset        - Turn off all attributes
    :bright       - Set bright mode
    :underline    - Set underline mode
    :blink        - Set blink mode
    :swap         - Swap foreground and background color
    :hide         - Hide text (set foreground to background color)


Usage:

require 'cli-colorize'
class HelloConsole
  include CLIColorize
  CLIColorize.default_color = :red   # set the default foreground color (initially :blue)

  def say_hello
    colorize('Hello Pretty Console!') # prints "Hello Pretty Console!" in red
  end

  def fancy_greeting
    colorize('Hello Console.', { :foreground => :blue, :background => :yellow, :config => :underline } )
  end

  def in_color(set)
    if set == true
      CLIColorize.on
    else
      CLIColorize.off
    end
  end
end

console = HelloConsole.new
console.say_hello                               # prints "Hello Pretty Console!" in red
console.fancy_greeting                          # prints "Hello Console." in blue, underlined, with a yellow background
console.in_color(false)
console.safe_colorize('Hi again.')              # not colorized
console.in_color(true)
console.safe_colorize("Let's try that again.")  # prints "Let's try that again." in red.