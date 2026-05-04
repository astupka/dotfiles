IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{Dir.home}/.irb_history"
IRB.conf[:USE_MULTILINE] = false if RUBY_VERSION >= "3.1"

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

require 'rubygems'
begin
#  require 'utility_belt'
  require 'interactive_editor'
rescue LoadError => e
  warn "Missing utility_belt or interactive_editor gem"
  puts e
end

