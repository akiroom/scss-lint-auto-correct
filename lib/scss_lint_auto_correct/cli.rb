require 'scss_lint/cli'
require 'scss_lint_auto_correct/options'

module SCSSLintAutoCorrect
  class CLI
    attr_reader :log
    def initialize(logger)
      @log = logger
    end

    # Call block when scss-lint returns only warnings.
    def run(options)
      act_on_options(options)
    end

    private

    def act_on_options(options)
      log.color_enabled = options.fetch(:color, log.tty?)

      if options[:help]
        log.log options[:help]
      elsif options[:version]
        log.log "scss-lint-auto-correct #{SCSSLintAutoCorrect::VERSION}"
      else
        scan_for_lints(options)
      end
    end

    def scan_for_lints(options)
      # Build arguments
      linter__args = ''
      if options.fetch(:color, log.tty?)
        linter__args += '--color '
      end

      # Build CLI command
      cli_code =
        if ENV['BUNDLE_GEMFILE']
          "bundle exec scss-lint #{linter__args}"
        else
          "scss-lint #{linter__args}"
        end

      # Run scss-lint
      Open3.popen3(cli_code) do |stdin, stdout, _stderr, wait_thr|
        exit_status = wait_thr.value.exitstatus

        # Check exit status
        if exit_status == SCSSLint::CLI::EXIT_CODES[:warning]
          # Can treat only warnings
          # -> Start to auto-correct it.
          SCSSLintAutoCorrect::AutoCorrector.new(options.merge(log: log)).run(stdout.read)
        else
          # Cannot treat this exit status.
          # -> returns scss-lint result directly.
          printf stdout.read
        end

        # Exit with status code returned from scss-lint
        exit exit_status
      end
    end
  end
end
