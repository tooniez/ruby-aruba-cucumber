# frozen_string_literal: true

require 'aruba/platforms/unix_platform'
require 'aruba/platforms/windows_command_string'
require 'aruba/platforms/windows_environment_variables'
require 'aruba/platforms/windows_which'

# Aruba
module Aruba
  # This abstracts OS-specific things
  module Platforms
    # WARNING:
    # All methods found here are not considered part of the public API of aruba.
    #
    # Those methods can be changed at any time in the feature or removed without
    # any further notice.
    #
    # This includes all methods for the Windows platform
    #
    # @private
    class WindowsPlatform < UnixPlatform
      def self.match?
        Gem.win_platform?
      end

      # @see UnixPlatform#command_string
      def command_string
        WindowsCommandString
      end

      # @see UnixPlatform#environment_variables
      def environment_variables
        WindowsEnvironmentVariables
      end

      # @see UnixPlatform#which
      def which(program, path = ENV['PATH'])
        WindowsWhich.new.call(program, path)
      end

      def builtin_shell_commands
        %w[cd dir echo exit set type]
      end

      def term_signal_supported?
        false
      end
    end
  end
end
