module SCSSLintAutoCorrect::Corrector
  class EmptyLineBetweenBlocks < AbstractCorrector
    def fix_it
      # Load
      file_lines = load_lines

      # Add newline
      file_lines.insert(line_num, "\n")

      # Save
      save_lines(file_lines)

      fixed_line
    end
  end
end
