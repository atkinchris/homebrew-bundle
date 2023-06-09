# frozen_string_literal: true

module Bundle
  module VscodeExtensionDumper
    module_function

    def reset!
      @extensions = nil
    end

    def extensions
      return [] if ENV["HOMEBREW_BUNDLE_EXCLUDE_VSCODE_EXTENSIONS"]

      @extensions ||= if Bundle.vscode_installed?
        `code --list-extensions 2>/dev/null`.split("\n")
      else
        []
      end
    end

    def dump
      extensions.map { |name| "vscode \"#{name}\"" }.join("\n")
    end
  end
end
