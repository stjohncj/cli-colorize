#
# Author :: Chris St. John (<mailto:chris@stjohnstudios.com>)
# Date   :: 08/02/2010
#

# A simple module for use when colorizing output to the terminal.
module CLIColorize

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

  # Set control characters around text to colorize output to the terminal.
  def CLIColorize.colorize(text, color=nil)
    unless color.is_a? Hash
      color = @@default_color if color.nil?
      "#{CTRLSTR_START+SET_FORE[color.to_sym]+CTRLSTR_DELIM}#{text}#{CTRLSTR_END}"
    else
      args = []
      args << SET_FORE[color[:foreground].to_sym] unless color[:foreground].nil?
      args << SET_BACK[color[:background].to_sym] unless color[:background].nil?
      args << CONFIG[color[:config].to_sym] unless color[:config].nil?
      control_string = args.join(';')
      "#{CTRLSTR_START+control_string+CTRLSTR_DELIM}#{text}#{CTRLSTR_END}"
    end
  end

  # Instance method that exposes the class method colorize to classes that `include 'CLIColorize'`
  def colorize(text, color=nil)
    CLIColorize.colorize(text, color)
  end

  # Call STDOUT.puts with the colorized text.
  def CLIColorize.puts(text, color=nil)
    STDOUT.puts CLIColorize.colorize(text, color)
  end

  # Call STDOUT.print with the colorized text.
  def CLIColorize.print(text, color=nil)
    STDOUT.print CLIColorize.colorize(text, color)
  end

  # Call STDOUT.puts with the colorized text if STDOUT is a tty device.
  # (If STDOUT has been redirected to a file, it will be a block device,
  # not a tty device, and we wouldn't want the ANSI codes inserted.
  def CLIColorize.puts_if_tty(text, color=nil)
    STDOUT.puts CLIColorize.colorize(text, color) if STDOUT.isatty
  end

  # instance method delegating to class method, see CLIColorize.puts_if_tty
  def puts_if_tty(text, color=nil)
    CLIColorize.puts_if_tty(text, color)
  end

  # Call STDOUT.print with the colorized text if STDOUT is a tty device.
  # (If STDOUT has been redirected to a file, it will be a block device,
  # not a tty device, and we wouldn't want the ANSI codes inserted.
  def CLIColorize.print_if_tty(text, color=nil)
    STDOUT.print CLIColorize.colorize(text, color) if STDOUT.isatty
  end

  # instance method delegating to class method, see CLIColorize.print_if_tty
  def print_if_tty(text, color=nil)
    CLIColorize.print_if_tty(text, color)
  end


  # Use safe_colorize in conjunction with CLIColorize.off and CLIColorize.on to conditionally
  # determine whether or not output will be given the control characters for colorization.
  # This is designed to work with a command-line switch to the script that uses this module.
  def CLIColorize.safe_colorize(text, color=nil)
    return text if @@off
    colorize(text, color)
  end

  # Instance method that exposes the class method safe_colorize to classes that `include 'CLIColorize'`
  def safe_colorize(text, color=nil)
    CLIColorize.safe_colorize(text, color)
  end

  # Makes the safe_colorize method return text with colorization control codes. This is the default state.
  def safe_colorize_active
    CLIColorize.on
  end
  alias safe_colorize_activate safe_colorize_active

  # Makes the safe_colorize method return text without colorization control codes.
  def safe_colorize_deactive
    CLIColorize.off
  end
  alias safe_colorize_deactivate safe_colorize_deactive

  # Call STDOUT.puts with the colorized text.
  def CLIColorize.safe_puts(text, color=nil)
    STDOUT.puts CLIColorize.safe_colorize(text, color)
  end

  # Call STDOUT.print with the colorized text.
  def CLIColorize.safe_print(text, color=nil)
    STDOUT.print CLIColorize.safe_colorize(text, color)
  end

  # Instance method that exposes the class method safe_puts to classes that `include 'CLIColorize'`
  def safe_puts(text, color=nil)
    CLIColorize.safe_puts(text, color)
  end

  # Instance method that exposes the class method safe_puts to classes that `include 'CLIColorize'`
  def safe_print(text, color=nil)
    CLIColorize.safe_print(text, color)
  end

  def CLIColorize.default_color; @@default_color; end
  def CLIColorize.default_color=(color)
    @@default_color = color.to_sym
  end
  def default_color; CLIColorize.default_color; end
  def default_color=(color)
    CLIColorize.default_color=(color)
  end

  def CLIColorize.on?
    ! @@off
  end

  private
  # Call CLIColorize.off to turn off colorizing (for instance to make the output safe
  # for evaluation or for output sometimes not headed to the terminal).
  def CLIColorize.off;  @@off = true;  nil; end
  def CLIColorize.on;   @@off = false; nil; end

end
