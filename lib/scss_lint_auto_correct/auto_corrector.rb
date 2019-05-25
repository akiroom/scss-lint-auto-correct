# frozen_string_literal: true
require 'scss_lint_auto_correct/corrector_factory'

module SCSSLintAutoCorrect
  class AutoCorrector
    # Create a CLI that outputs to the specified logger.
    #
    # @param logger [SCSSLint::Logger]
    def initialize(logger)
      @log = logger
    end

    def run(scss_lint_result)
      lines = scss_lint_result.split("\n").map do |line|
        # remove color control characters
        line.gsub(/\e\[\d+m/, '')
      end
      fix_for_lines(lines)
    end

    private

    def fix_for_lines(lines)
      result = lines.reverse.map do |line|
        SCSSLintAutoCorrect::CorrectorFactory.concrete(line).fix_it
      end.reverse

      # Output result
      result.each do |res|
        puts res
      end
    end
  end
end
