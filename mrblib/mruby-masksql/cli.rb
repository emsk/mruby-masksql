module MrubyMasksql
  class CLI
    OPTION = /\A(--|-)/

    def self.start(argv)
      new(argv).run
    end

    def initialize(argv)
      @command = command?(argv[1]) ? argv[1] : 'mask'
      @text ||= ''
      @options ||= {}
      parse_args(argv[1..-1])
    end

    def command?(arg)
      arg && !OPTION.match(arg)
    end

    def parse_args(args)
      opts = OptionParser.new
      opts.on('-i', '--in VALUE') { |v| @options[:in] = v }
      opts.on('-o', '--out VALUE') { |v| @options[:out] = v }
      opts.on('-c', '--config VALUE') { |v| @options[:config] = v }
      opts.on('--[no-]insert') { |v| @options[:insert] = v }
      opts.on('--[no-]replace') { |v| @options[:replace] = v }
      opts.on('--[no-]copy') { |v| @options[:copy] = v }
      opts.on('-v', '--version') { @command = 'version' }
      opts.on('-h', '--help') { @command = 'help' }
      opts.parse!(args)

      args.each do |arg|
        @text = arg unless OPTION.match(arg)
      end
    end

    def run
      case @command
      when 'mask'    then mask
      when 'init'    then init
      when 'version' then version
      when 'help'    then help(@text)
      else                help
      end
    end

    def mask
      return unless validate_options

      converter_options = @options.dup

      if @options[:config]
        converter_options[:config] = File.expand_path(@options[:config])
      else
        default_config = File.expand_path('.mask.yml')
        converter_options[:config] = default_config if File.exist?(default_config)
      end

      converter = Converter.new(converter_options)
      converter.mask
      puts "\e[32mDone.\e[0m"
    end

    def init
      puts Initializer.copy_template
    end

    def version
      puts "mruby-masksql #{MrubyMasksql::VERSION}"
    end

    def help(command = nil)
      Help.new(command).run
    end

    private

    def validate_options
      if @options[:in].nil? && @options[:out].nil?
        $stderr.puts "No value provided for required options '--in', '--out'"
        return false
      end

      if @options[:in].nil?
        $stderr.puts "No value provided for required options '--in'"
        return false
      end

      if @options[:out].nil?
        $stderr.puts "No value provided for required options '--out'"
        return false
      end

      in_file = File.expand_path(@options[:in])
      out_file = File.expand_path(@options[:out])

      if in_file == out_file
        $stderr.puts "\e[31mOutput file is the same as input file.\e[0m"
        return false
      end

      true
    end
  end
end
