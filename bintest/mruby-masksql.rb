require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), '../mruby/bin/mruby-masksql')
IN_PATH = File.join(File.dirname(__FILE__), 'sqls/in.sql')
OUT_PATH = File.join(File.dirname(__FILE__), 'sqls/out.sql')
CONFIG_PATH = File.join(File.dirname(__FILE__), 'sqls/config.yml')

# mask

assert('mask -i in.sql -o out.sql -c config.yml') do
  output, error, status = Open3.capture3("#{BIN_PATH} mask -i #{IN_PATH} -o #{OUT_PATH} -c #{CONFIG_PATH}")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal "\e[32mDone.\e[0m\n", output
  assert_equal '', error
end

assert('mask') do
  output, error, status = Open3.capture3("#{BIN_PATH} mask")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal '', output
  assert_equal "No value provided for required options '--in', '--out'\n", error
end

assert('mask -i in.sql') do
  output, error, status = Open3.capture3("#{BIN_PATH} mask -i in.sql")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal '', output
  assert_equal "No value provided for required options '--out'\n", error
end

assert('mask -o out.sql') do
  output, error, status = Open3.capture3("#{BIN_PATH} mask -o out.sql")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal '', output
  assert_equal "No value provided for required options '--in'\n", error
end

# version

assert('version') do
  require_relative '../mrblib/mruby-masksql/version'
  output, status = Open3.capture2("#{BIN_PATH} version")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal "mruby-masksql #{MrubyMasksql::VERSION}\n", output
end

assert('--version') do
  require_relative '../mrblib/mruby-masksql/version'
  output, status = Open3.capture2("#{BIN_PATH} --version")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal "mruby-masksql #{MrubyMasksql::VERSION}\n", output
end

assert('version') do
  require_relative '../mrblib/mruby-masksql/version'
  output, status = Open3.capture2("#{BIN_PATH} -v")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal "mruby-masksql #{MrubyMasksql::VERSION}\n", output
end

# help

assert('help') do
  require_relative '../mrblib/mruby-masksql/help'
  output, status = Open3.capture2("#{BIN_PATH} help")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal MrubyMasksql::Help::USAGE_COMMON, output
end

assert('help mask') do
  require_relative '../mrblib/mruby-masksql/help'
  output, status = Open3.capture2("#{BIN_PATH} help mask")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal MrubyMasksql::Help::USAGE_MASK, output
end

assert('help init') do
  require_relative '../mrblib/mruby-masksql/help'
  output, status = Open3.capture2("#{BIN_PATH} help init")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal MrubyMasksql::Help::USAGE_INIT, output
end

assert('wrong command') do
  require_relative '../mrblib/mruby-masksql/help'
  output, status = Open3.capture2("#{BIN_PATH} a")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal MrubyMasksql::Help::USAGE_COMMON, output
end

assert('no command') do
  output, error, status = Open3.capture3("#{BIN_PATH}")

  assert_true status.success?, 'Process did not exit cleanly'
  assert_equal '', output
  assert_equal "No value provided for required options '--in', '--out'\n", error
end
