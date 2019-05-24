module SCSSLintAutoCorrect::Corrector
  class SpaceAfterPropertyName < AbstractCorrector
    def fix_it
      # Load
      file_lines = load_lines

      # Replace
      file_lines[line_num-1] = file_lines[line_num-1].gsub(/^(.{#{char_num - 1}})(.+?)\s+?:/) do
        # "わ#{$1}わ#{$2}わ"
        "#{$1}#{$2}:"
      end

      # Save
      save_lines(file_lines)

      fixed_line
    end
  end
end
