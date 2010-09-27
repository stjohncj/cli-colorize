#!/usr/bin/env ruby

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

console = HelloConsole.new
console.say_hello                               # prints "Hello Pretty Console!" in red
console.fancy_greeting                          # prints "Hello Console." in blue, underlined, with a yellow background
console.in_color(false)
puts console.safe_colorize('Hi again.')              # not colorized
console.in_color(true)
puts console.safe_colorize("Let's try that again.")  # prints "Let's try that again." in red.