#
# Author :: Chris St. John (<mailto:chris@stjohnstudios.com>)
# Date   :: 08/02/2010
#

# A simple module for use when colorizing output to the terminal.
module CLIColorize

  attr_accessor :off

  @@off = false
  @@default_color = :blue

  # ANSI control codes
  # 0	Turn off all attributes
  # 1	Set bright mode
  # 4	Set underline mode
  # 5	Set blink mode
  # 7	Exchange foreground and background colors
  # 8	Hide text (foreground color would be the same as background)
  # 30	Black text
  # 31	Red text
  # 32	Green text
  # 33	Yellow text
  # 34	Blue text
  # 35	Magenta text
  # 36	Cyan text
  # 37	White text
  # 39	Default text color
  # 40	Black background
  # 41	Red background
  # 42	Green background
  # 43	Yellow background
  # 44	Blue background
  # 45	Magenta background
  # 46	Cyan background
  # 47	White background
  # 49	Default background color

  CTRLSTR_START = "\033["
  CTRLSTR_END = "\033[0m"
  CTRLSTR_DELIM = 'm'
  CONFIG = {
    :reset =>       '0',
    :bright =>      '1',
    :underline =>   '4',
    :blink =>       '5',
    :swap =>        '7',
    :hide =>        '8'
  }
  SET_FORE = {
      :black =>     '30',
      :red =>       '31',
      :green =>     '32',
      :yellow =>    '33',
      :blue =>      '34',
      :magenta =>   '35',
      :cyan =>      '36',
      :white =>     '37',
      :default =>   '39'
  }
  SET_BACK = {
      :black =>     '40',
      :red =>       '41',
      :green =>     '42',
      :yellow =>    '43',
      :blue =>      '44',
      :magenta =>   '45',
      :cyan =>      '46',
      :white =>     '47',
      :default =>   '49'
  }

  # Use safe_colorize in conjunction with CLIColorize.off and CLIColorize.on to conditionally
  # determine whether or not output will be given the control characters for colorization.
  # This is designed to work with a command-line switch to the script that uses this module.
  def safe_colorize(text, color=nil)
    return text if @@off
    colorize(text, color)
  end

  # Set control characters around text to colorize output to the terminal.
  def colorize(text, color=nil)
    unless color.is_a? Hash
      color = @@default_color if color.nil?
      "#{CTRLSTR_START+SET_FORE[color.to_sym]+CTRLSTR_DELIM}#{text}#{CTRLSTR_END}"
    else
      control_string = [ SET_FORE[color[:foreground].to_sym], SET_BACK[color[:background].to_sym], CONFIG[color[:config].to_sym] ].join(';')
      "#{CTRLSTR_START+control_string+CTRLSTR_DELIM}#{text}#{CTRLSTR_END}"
    end
  end

  # Call CLIColorize.off to turn off colorizing (for instance to make the output safe
  # for evaluation or for output not headed to the terminal).
  def self.off;  @@off = true;   end
  def self.on;   @@off = false;  end
  def self.default_color; @@default_color; end
  def self.default_color=(color)
    @@default_color = color.to_sym
  end
  def off;  @@off = true;   end
  def on;   @@off = false;  end
end
