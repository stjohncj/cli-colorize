require File.join(File.dirname(__FILE__), 'helper')

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
end
