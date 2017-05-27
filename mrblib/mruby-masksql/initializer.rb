module MrubyMasksql
  class Initializer
    CONFIG_FILE = '.mask.yml'.freeze
    CONFIG_CONTENT = <<-EOS.freeze
# This file was generated by the `mruby-masksql init` command.
# Edit this file to configure the masking behavior.
# See https://github.com/emsk/mruby-masksql for more details.

# mark: '[mask]'
# targets:
#   - table: people
#     columns: 4
#     indexes:
#       2: 氏名[mask]
#       3: email-[mask]@example.com
#   - table: cats
#     columns: 2
#     indexes:
#       0: code-[mask]
#       1: Cat name [mask]
#   - table: dogs
#     columns: 4
#     indexes:
#       0: code-[mask]
#       1: Dog name [mask]
#     group_indexes:
#       - 2
#       - 3
    EOS

    def self.copy_template
      to = File.expand_path(CONFIG_FILE)
      return "\e[33mexist #{to}\e[0m" if FileTest.exist?(to)

      File.open(to, 'w') do |out_file|
        out_file.puts CONFIG_CONTENT
      end
      "\e[32mcreate #{to}\e[0m"
    end
  end
end
