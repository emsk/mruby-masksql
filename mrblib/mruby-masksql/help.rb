module MrubyMasksql
  class Help
    USAGE_COMMON = <<-EOS
Usage:
  mruby-masksql help [COMMAND]                                            # Describe available commands or one specific command
  mruby-masksql mask -i, --in=INPUT FILE PATH -o, --out=OUTPUT FILE PATH  # Mask sensitive values in a SQL file
  mruby-masksql version, -v, --version                                    # Print the version
    EOS

    USAGE_MASK = <<-EOS
Usage:
  mruby-masksql mask -i, --in=INPUT FILE PATH -o, --out=OUTPUT FILE PATH

Options:
  -i, --in=INPUT FILE PATH
  -o, --out=OUTPUT FILE PATH
  -c, [--config=CONFIG FILE PATH]
      [--insert=MASK `INSERT` SQL], [--no-insert]
      [--replace=MASK `REPLACE` SQL], [--no-replace]
      [--copy=MASK `COPY` SQL], [--no-copy]

Mask sensitive values in a SQL file
    EOS

    def initialize(command = nil)
      @command = command
    end

    def run
      puts case @command
           when 'mask' then USAGE_MASK
           else             USAGE_COMMON
           end
    end
  end
end
