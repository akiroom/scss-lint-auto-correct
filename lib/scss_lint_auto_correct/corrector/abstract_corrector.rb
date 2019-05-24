module SCSSLintAutoCorrect::Corrector
  class AbstractCorrector
    attr_reader :line
    attr_reader :file_path
    attr_reader :line_num
    attr_reader :char_num
    attr_reader :level
    attr_reader :class_name
    attr_reader :desc

    def initialize(line)
      @line = line

      matched = line.match(/^(?<file_path>.+):(?<line_num>(\d)+):(?<char_num>(\d)+) (?<level>\[[A-Z]\]) (?<class_name>.+?): (?<desc>.+)$/)

      @file_path = matched[:file_path]
      @line_num = matched[:line_num]
      @char_num = matched[:char_num]
      @level = matched[:level]
      @class_name = matched[:class_name]
      @desc = matched[:desc]
    end

    def fix_it
      if self.class.name == 'SCSSLintAutoCorrect::Corrector::AbstractCorrector'
        nothing_line
      else
        raise NotImplementedError
      end
    end

    def fixed_line
      "#{file_path.cyan}:#{line_num.magenta}:#{line_num.magenta} #{'[FIXED]'.green} #{class_name.green}: #{desc}"
    end

    def nothing_line
      "#{file_path.cyan}:#{line_num.magenta}:#{line_num.magenta} #{level.yellow} #{class_name.green}: #{desc}"
    end
  end
end
