module SCSSLintAutoCorrect::Corrector
  class ColorKeyword < AbstractCorrector
    # Concrete
    def corrector(line)
      self.class.new(line)
    end

    def fix_it
      matched = desc.match(/^.+? `(?<before>.+?)` .+? `#(?<after>.+?)`$/)
      pp matched
      fixed_line
    end
  end
end
