module SCSSLintAutoCorrect::Corrector
  class ColorKeyword < AbstractCorrector
    # Concrete
    def corrector(line)
      self.class.new(line)
    end

    def fix_it
      fixed_line
    end
  end
end
