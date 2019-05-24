module SCSSLintAutoCorrect::Corrector
  class ZeroUnit < AbstractCorrector
    def fix_it
      matched = desc.match(/`(?<before>.+?)` should be written without units as `(?<after>.+?)`/)

      if rewrite_sub_line(matched[:before], matched[:after])
        fixed_line
      else
        nothing_line
      end
    end
  end
end
