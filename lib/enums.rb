# encoding: utf-8

## stdlibs
require 'pp'


## our own code
require 'enums/version'    # note: let version always go first


## forward declarations
module Safe
  ## note: use ClassMethods pattern for auto-including class methods
  ##   note ClassMethods module is called SafeHelper
  def self.included( klass )
    klass.extend( SafeHelper )
  end

  module SafeHelper; end
  ## note: also extends (include a helper methods to Safe itself)
  ##  lets you use:
  ##  module Safe
  ##    enum :Color, :red, :green, :blue
  ##  end
  extend SafeHelper
end # module Safe



require 'enums/enum'
require 'enums/enum_builder'
require 'enums/flags'
require 'enums/flags_builder'




module Safe
module SafeHelper
  def enum( class_name, *args, flags: false, options: {} )

    ## note: allow "standalone" option flags or
    ## option hash
    defaults = { flags: flags }
    options = defaults.merge( options )
    pp options

    ########################################
    # note: lets you use:
    #   enum :Color, :red, :green, :blue
    #    -or-
    #   enum :Color, [:red, :green, :blue]
    if args[0].is_a?( Array )
      keys = args[0]
    else
      keys = args
    end

    if options[:flags]
      Flags.new( class_name, *keys )
    else
      Enum.new( class_name, *keys )
    end
  end
end # module SafeHelper
end # module Safe


puts Enums.banner   # say hello
