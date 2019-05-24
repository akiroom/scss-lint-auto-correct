module SCSSLintAutoCorrect::Corrector
  class LeadingZero < AbstractCorrector
    def fix_it
      matched = desc.match(/`(?<before>[\d\.]+)` .+ `\.(?<after>\d+)`/)

      rewrite_sub_line(matched[:before], ".#{matched[:after]}")

      fixed_line
    end
  end
end
