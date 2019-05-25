require 'scss_lint/cli'

module SCSSLintAutoCorrect
  class SCSSLintBypass
    # Call block when scss-lint returns only warnings.
    def run(color: )
      # Build arguments
      args = " #{color && '--color'}"

      # Build CLI command
      cli_code =
        if ENV['BUNDLE_GEMFILE']
          "bundle exec scss-lint #{args}"
        else
          "scss-lint #{args}"
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
