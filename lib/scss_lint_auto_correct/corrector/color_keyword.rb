module SCSSLintAutoCorrect::Corrector
  class ColorKeyword < AbstractCorrector
    def fix_it
      matched = desc.match(/^.+? `(?<before>.+?)` .+? `#(?<after>.+?)`$/)

      rewrite_gsub_line(matched[:before], "##{matched[:after]}")

      fixed_line
    end
  end
end
