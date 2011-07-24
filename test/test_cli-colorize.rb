require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

require 'tempfile'

class TestCliColorize < Test::Unit::TestCase
  context "Using the module directly" do
    should "have a working colorize method" do
      assert_equal "\033[34mTEST TEXT\033[0m", CLIColorize.colorize('TEST TEXT', :blue)
    end
    should "have working safe_colorize, CLIColorize.off, and CLIColorize.on methods " do
      assert_nothing_raised { CLIColorize.off }
      assert_equal 'TEST TEXT', CLIColorize.safe_colorize('TEST TEXT', :blue)
      assert_nothing_raised { CLIColorize.on }
      assert_equal "\033[34mTEST TEXT\033[0m", CLIColorize.safe_colorize('TEST TEXT', :blue)
    end
    should "have working default_color= and default color methods" do
      assert_nothing_raised { CLIColorize.default_color = :red }
      assert_equal :red, CLIColorize.default_color
      assert_nothing_raised { CLIColorize.default_color = :green }
      assert_equal :green, CLIColorize.default_color
    end
    should "have a working puts method" do
      CLIColorize.puts('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
    end
    should "have a working safe_puts method" do
      CLIColorize.safe_puts('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      CLIColorize.safe_puts('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
    should "have a working print method" do
      CLIColorize.print('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
    end
    should "have a working safe_print method" do
      CLIColorize.safe_print('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      CLIColorize.safe_print('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
    should "use ANSI color escape sequences when outputting to a STDOUT that is a tty" do
      flunk unless STDOUT.tty?
      CLIColorize.print_colorized_if_tty('foo,', :foreground => :red, :background => :yellow)
      CLIColorize.puts_colorized_if_tty('bar: ', :foreground => :red, :background => :yellow)
      CLIColorize.puts_colorized_if_tty('Are foo and bar both in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
    end
    should "NOT use ANSI color escape sequences when outputting to a STDOUT that is NOT a tty" do
      orig_std_out = STDOUT.clone
      tempfile_path = File.join(File.dirname(__FILE__), 'tempfile.txt')
      STDOUT.reopen(File.open(tempfile_path, 'w+'))
      CLIColorize.print_colorized_if_tty('foo,')
      CLIColorize.puts_colorized_if_tty('bar: Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      STDOUT.reopen(orig_std_out)
      puts File.read(tempfile_path)
      File.delete(tempfile_path)
      default_color = gets.chomp
      flunk unless default_color == 'Y' or default_color == ''
    end
  end

  context "Including the module in a class" do
    require 'sample_class_include'
    cli = HelloConsole.new
    should "have a working colorize method" do
      assert_equal "\033[34mTEST TEXT\033[0m", cli.colorize('TEST TEXT', :blue)
    end
    should "have working safe_colorize, CLIColorize.off, and CLIColorize.on methods " do
      assert_nothing_raised { cli.safe_colorize_deactive }
      assert_equal 'TEST TEXT', cli.safe_colorize('TEST TEXT', :blue)
      assert_nothing_raised { cli.safe_colorize_active }
      assert_equal "\033[34mTEST TEXT\033[0m", cli.safe_colorize('TEST TEXT', :blue)
    end
    should "have working default_color= and default color methods" do
      assert_nothing_raised { CLIColorize.default_color = :red }
      assert_equal :red, CLIColorize.default_color
      assert_nothing_raised { CLIColorize.default_color = :green }
      assert_equal :green, CLIColorize.default_color
    end
    should "have a working safe_puts method" do
      cli.safe_puts('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      cli.safe_puts('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
    should "have a working safe_print method" do
      cli.safe_print('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      cli.safe_print('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
  end

  context "Extending the module with a class" do
    require 'sample_class_extend'
    should "have a working colorize method" do
      assert_equal "\033[34mTEST TEXT\033[0m", HelloConsole.colorize('TEST TEXT', :blue)
    end
    should "have working safe_colorize, CLIColorize.off, and CLIColorize.on methods " do
      assert_nothing_raised { HelloConsole.safe_colorize_deactive }
      assert_equal 'TEST TEXT', HelloConsole.safe_colorize('TEST TEXT', :blue)
      assert_nothing_raised { HelloConsole.safe_colorize_active }
      assert_equal "\033[34mTEST TEXT\033[0m", HelloConsole.safe_colorize('TEST TEXT', :blue)
    end
    should "have working default_color= and default color methods" do
      assert_nothing_raised { HelloConsole.default_color = :red }
      assert_equal :red, HelloConsole.default_color
      assert_nothing_raised { HelloConsole.default_color = :green }
      assert_equal :green, HelloConsole.default_color
    end
    should "have a working safe_puts method" do
      HelloConsole.safe_puts('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      HelloConsole.safe_puts('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
    should "have a working safe_print method" do
      HelloConsole.safe_print('Is this text in red with a yellow background? (Y/n):', :foreground => :red, :background => :yellow)
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
      CLIColorize.off
      HelloConsole.safe_print('Is this text the default color? (Y/n):', :foreground => :red, :background => :yellow)
      default_color = gets.chomp
      CLIColorize.on
      flunk unless default_color == 'Y' or default_color == ''
    end
  end
  
  context "Extends the String class" do
    should "have working config actions" do
      str = 'Is this text underlined? (Y/n):'
      puts str.underline
      underline = gets.chomp
      flunk unless underline == 'Y' or underline == ''
    end
    should "have working foreground actions" do
      str = 'Is this text in red? (Y/n):'
      puts str.red
      red = gets.chomp
      flunk unless red == 'Y' or red == ''
    end
    should "have working background actions" do
      str = 'Is this text in red with a yellow background? (Y/n):'
      puts str.red.bg_yellow
      red_on_yellow = gets.chomp
      flunk unless red_on_yellow == 'Y' or red_on_yellow == ''
    end
    should "NOT use ANSI color escape sequences when outputting to a STDOUT that is NOT a tty" do
      orig_std_out = STDOUT.clone
      tempfile_path = File.join(File.dirname(__FILE__), 'tempfile.txt')
      STDOUT.reopen(File.open(tempfile_path, 'w+'))
      print 'foo,'.green
      puts 'bar: Is this text the default color? (Y/n):'.red.bg_yellow
      STDOUT.reopen(orig_std_out)
      puts File.read(tempfile_path)
      File.delete(tempfile_path)
      default_color = gets.chomp
      flunk unless default_color == 'Y' or default_color == ''
    end
  end
end
