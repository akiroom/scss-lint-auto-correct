module SCSSLintAutoCorrect::Corrector
  class FinalNewline < AbstractCorrector
    def fix_it
      # Load
      file_lines = load_lines

      # Add newline
      file_lines.push("\n")

      # Save
      save_lines(file_lines)

      fixed_line
    end
  end
end
