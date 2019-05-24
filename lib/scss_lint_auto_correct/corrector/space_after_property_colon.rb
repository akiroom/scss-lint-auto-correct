module SCSSLintAutoCorrect::Corrector
  class SpaceAfterPropertyColon < AbstractCorrector
    def fix_it
      before_regexp = /^(.{#{char_num-1}})(?<hoge>.+?):/
      rewrite_sub_line(before_regexp) do |match|
        "#{match} "
      end

      fixed_line
    end
  end
end
