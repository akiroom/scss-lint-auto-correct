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
      @line_num = matched[:line_num].to_i
      @char_num = matched[:char_num].to_i
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

    # The text for output with success to correct.
    def fixed_line
      "#{file_path.cyan}:#{line_num.to_s.magenta}:#{char_num.to_s.magenta} #{'[FIXED]'.green} #{class_name.green}: #{desc}"
    end

    # The text for output with nothing.
    def nothing_line
      "#{file_path.cyan}:#{line_num.to_s.magenta}:#{char_num.to_s.magenta} #{level.yellow} #{class_name.green}: #{desc}"
    end

    # Replace with before after
    def rewrite_sub_line(before, after = nil)
      # Load
      file_lines = load_lines

      # Replace color keyword to hex code.
      if block_given?
        file_lines[line_num-1] = file_lines[line_num-1].sub(before) { |match| yield(match) }
      else
        file_lines[line_num-1] = file_lines[line_num-1].sub(before, after)
      end

      # Save
      save_lines(file_lines)
    end

    # Insert text into line
    def insert_text_into_line(text)
      # Load
      file_lines = load_lines

      # Replace color keyword to hex code.
      file_lines[line_num-1].insert(char_num, text)

      # Save
      save_lines(file_lines)
    end

    private

    def load_lines
      File.readlines(file_path)
    end

    def save_lines(file_lines)
      File.write(file_path, file_lines.join)
    end
  end
end
