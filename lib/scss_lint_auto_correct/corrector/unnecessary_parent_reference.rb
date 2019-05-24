module SCSSLintAutoCorrect::Corrector
  class UnnecessaryParentReference < AbstractCorrector
    def fix_it
      # Load
      file_lines = load_lines

      # Replace color keyword to hex code.
      before_line = file_lines[line_num-1]
      after_line = before_line.sub(/&\s*>/, '>')

      if before_line == after_line
        nothing_line
      else
        file_lines[line_num-1] = after_line

        # Save
        save_lines(file_lines)

        fixed_line
      end
    end
  end
end
