# frozen_string_literal: true

module Phony
  
  # Add config.
  class << self
    attr_writer :config
    
    def config
      # Default config includes all CCs.
      @config ||= Config.new([], [])
    end
  end
  
  # The Config class is only used to configure Phony and to load specific
  # subsets of CCs.
  #
  class Config
    
    attr_reader :included_ccs, :excluded_ccs
    
    def initialize included_ccs, excluded_ccs
      @included_ccs = included_ccs || []
      @excluded_ccs = excluded_ccs || []
    end
    
    def load? cc
      return false if has_excluded? && excluded_ccs.include?(cc)
      
      if has_included?
        # We have to check the included_ccs, otherwise false.
        return true if included_ccs.include?(cc)
        
        false
      else
        # It's not in excluded and no included was given.
        true
      end
    end
    def has_included?
      !included_ccs.empty?
    end
    def has_excluded?
      !excluded_ccs.empty?
    end
    
    # Use as follows:
    #
    #   require 'phony/config'
    #   
    #   # Load only these:
    #   Phony::Config.load(only: ['41', '44'])
    #   # or all except these:
    #   Phony::Config.load(except: ['41', '44'])
    #   # or "only", in short form.
    #   Phony::Config.load('41', '44')
    #   # or even shorter form:
    #   Phony::Config.load(41, 44)
    #
    def self.load *options
      # Extract options.
      last = options.last
      only, except = if last.respond_to?(:to_hash)
        # We have the explicit form.
        [last[:only], last[:except]]
      elsif options.respond_to?(:to_ary)
        # We have the convenience short forms.
        [options, []]
      end
      
      # Set defaults.
      only, except = [only || [], except || []]
      # Convert to expected format if possible.
      only, except = [only.map(&:to_s), except.map(&:to_s)]
      
      # Check params.
      raise "Params given to Phony::Config.load must be Array-like. The one given was: #{only}" unless only.respond_to?(:to_ary)
      raise "Params given to Phony::Config.load must be Array-like. The one given was: #{except}" unless except.respond_to?(:to_ary)
      
      # Configure Phony.
      Phony.config = new(only, except)
      
      # Load phony.
      Kernel.load File.expand_path('../../phony.rb', __FILE__)
      
      # Return the stored config data.
      Phony.config
    end
    
  end
end