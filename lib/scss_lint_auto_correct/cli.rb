# frozen_string_literal: true
require('pp')
require 'scss_lint_auto_correct/corrector_factory'

module SCSSLintAutoCorrect
  class CLI
    # Create a CLI that outputs to the specified logger.
    #
    # @param logger [SCSSLint::Logger]
    def initialize(logger)
      @log = logger
    end

    def run(scss_lint_result)
      fix_for_lines(scss_lint_result.split("\n"))
    # rescue StandardError => ex
      # handle_runtime_exception(ex, options)
    end

    private

    def fix_for_lines(lines)
      p lines
      result = lines.reverse.map do |line|
        cleaned_line = line.gsub(/\e\[\d+m/, '') # remove color control characters
        SCSSLintAutoCorrect::CorrectorFactory.concrete(cleaned_line).fix_it
      end.reverse

      result.each do |res|
        puts res
      end

      # runner = Runner.new(config)
      # files = files_to_lint(options, config)
      # runner.run(files)
      # report_lints(options, runner.lints, files)
      #
      # if runner.lints.any?(&:error?)
      #   halt :error
      # elsif runner.lints.any?
      #   halt :warning
      # else
      #   halt :ok
      # end
    end

    def mark_line_as_fixed(line)

    end
  end
end
