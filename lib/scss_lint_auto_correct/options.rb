require 'optparse'

module SCSSLintAutoCorrect
  # Handles option parsing for the command line application.
  class Options
    def parse(args)
      @options = {}

      OptionParser.new do |parser|
        parser.banner = "Usage: #{parser.program_name} [options] [scss-files]"

        add_info_options parser
      end.parse!(args)

      # Any remaining arguments are assumed to be files
      @options[:files] = args

      @options
    rescue OptionParser::InvalidOption => e
      raise SCSSLint::Exceptions::InvalidCLIOption,
        e.message,
        e.backtrace
    end

    private

    def add_info_options(parser)
      parser.on('--[no-]color', 'Force output to be colorized') do |color|
        @options[:color] = color
      end

      parser.on_tail('-h', '--help', 'Display help documentation') do
        @options[:help] = parser.help
      end

      parser.on_tail('-v', '--version', 'Display version') do
        @options[:version] = true
      end
    end
  end
end
