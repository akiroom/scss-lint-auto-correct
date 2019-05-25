require 'scss_lint/cli'
require 'scss_lint_auto_correct/options'

module SCSSLintAutoCorrect
  class SCSSLintBypass
    # Call block when scss-lint returns only warnings.
    def run(options, &block)
      act_on_options(options, &block)
    end

    private

    def act_on_options(options, &block)
      if options[:help]
        puts options[:help]
      elsif options[:version]
        puts "scss-lint-auto-correct #{SCSSLintAutoCorrect::VERSION}"
      else
        scan_for_lints(options, &block)
      end
    end

    def scan_for_lints(options)
      # Build arguments
      bypass_args = ''
      if options[:color]
        bypass_args += "--color "
      end

      # Build CLI command
      cli_code =
        if ENV['BUNDLE_GEMFILE']
          "bundle exec scss-lint #{bypass_args}"
        else
          "scss-lint #{bypass_args}"
        end

      # Run scss-lint
      Open3.popen3(cli_code) do |stdin, stdout, stderr, wait_thr|
        stdin.close
        exit_status = wait_thr.value.exitstatus
        if exit_status == SCSSLint::CLI::EXIT_CODES[:warning]
          # only warnings
          yield stdout.read, exit_status
        else
          # scss-lint-auto-correct cannot treat this exit status.
          printf stdout.read
          exit exit_status
        end
      end
    end
  end
end
