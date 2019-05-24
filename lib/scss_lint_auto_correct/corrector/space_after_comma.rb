module SCSSLintAutoCorrect::Corrector
  class SpaceAfterComma < AbstractCorrector
    def fix_it
      insert_text_into_line(' ')

      fixed_line
    end
  end
end
