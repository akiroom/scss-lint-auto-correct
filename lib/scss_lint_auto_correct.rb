# frozen_string_literal: true

require 'thor'
require 'colorize'
require 'scss_lint_auto_correct/version'
Dir[File.expand_path('scss_lint_auto_correct/corrector/**/*.rb', File.dirname(__FILE__))].sort.each do |file|
  require file
end

module SCSSLintAutoCorrect
  class Error < StandardError; end
  # Your code goes here...
end
