
module SCSSLintAutoCorrect
  class CorrectorFactory
    def self.concrete(line)
      instance = ::SCSSLintAutoCorrect::Corrector::AbstractCorrector.new(line)
      Object.const_get("::SCSSLintAutoCorrect::Corrector::#{instance.class_name}").new(line)
    rescue NameError => e
      instance
    end
  end
end
