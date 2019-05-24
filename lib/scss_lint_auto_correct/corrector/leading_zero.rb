module SCSSLintAutoCorrect::Corrector
  class LeadingZero < AbstractCorrector
    # Concrete
    def corrector(line)
      self.class.new(line)
    end

    def fix_it
      matched = desc.match(/`(?<before>[\d\.]+)` .+ `\.(?<after>\d+)`/)

      rewrite_gsub_line(matched[:before], ".#{matched[:after]}")

      fixed_line
    end
  end
end
