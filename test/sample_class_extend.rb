require 'cli-colorize'

class HelloConsole
  extend CLIColorize

  default_color = :red   # set the default foreground color (initially :blue)

  def self.say_hello
    puts colorize('Hello Pretty Console!')
  end
end