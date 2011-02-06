require 'cli-colorize'

class HelloConsole
  include CLIColorize

  def initialize
    CLIColorize.default_color = :red   # set the default foreground color (initially :blue)
  end

  def say_hello
    puts colorize('Hello Pretty Console!')
  end

  def fancy_greeting
    puts colorize('Hello Console.', { :foreground => :blue, :background => :yellow, :config => :underline } )
  end

  def in_color(set)
    if set == true
      CLIColorize.on
    else
      CLIColorize.off
    end
  end
end