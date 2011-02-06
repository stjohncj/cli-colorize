#!/usr/bin/env ruby

require 'sample_class'

console = HelloConsole.new
console.say_hello                               # prints "Hello Pretty Console!" in red
console.fancy_greeting                          # prints "Hello Console." in blue, underlined, with a yellow background
console.in_color(false)
puts console.safe_colorize('Hi again.')              # not colorized
console.in_color(true)
puts console.safe_colorize("Let's try that again.")  # prints "Let's try that again." in red.