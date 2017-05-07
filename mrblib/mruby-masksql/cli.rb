module MrubyMasksql
  class CLI
    OPTION = /^(--|-)(.+)=(.*)$/

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
      args.each do |arg|
        option = OPTION.match(arg)
        if option
          @options[option[2].gsub('-', '_').to_sym] = option[3]
        else
          @text = arg
        end
      end
    end

    def run
      case @command
      when 'mask'                       then mask
      when 'init'                       then init
      when 'version', '--version', '-v' then version
      when 'help'                       then help(@text)
      else                                   help
      end
    end

    def mask
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
  end
end
