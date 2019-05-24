module SCSSLintAutoCorrect::Corrector
  class ColorKeyword < AbstractCorrector
    # Concrete
    def corrector(line)
      self.class.new(line)
    end

    def fix_it
      matched = desc.match(/^.+? `(?<before>.+?)` .+? `#(?<after>.+?)`$/)

      # Load
      file_lines = File.readlines(file_path)

      # Replace color keyword to hex code.
      file_lines[line_num-1] = file_lines[line_num-1].gsub(matched[:before], "##{matched[:after]}")

      # Save
      File.write(file_path, file_lines.join)

      fixed_line
    end
  end
end
