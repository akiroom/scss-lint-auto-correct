module SCSSLintAutoCorrect::Corrector
  class Indentation < AbstractCorrector
    def fix_it
      matched = desc.match(/Line should be indented (?<after>\d+) spaces, but was indented (?<before>\d+) spaces/)

      rewrite_sub_line(/^\s{#{matched[:before].to_i}}/, ' ' * matched[:after].to_i)

      fixed_line
    end
  end
end
