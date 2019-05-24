module SCSSLintAutoCorrect::Corrector
  class UnnecessaryMantissa < AbstractCorrector
    def fix_it
      if rewrite_sub_line(/0*\.0+[A-Za-z]{0,3}/, '0')
        fixed_line
      else
        nothing_line
      end
    end
  end
end
