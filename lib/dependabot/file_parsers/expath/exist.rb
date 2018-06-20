# frozen_string_literal: true

require "nokogiri"

require "dependabot/dependency"
require "dependabot/file_parsers/base"

# For details on how to resolve EXPath dependencies see http://expath.org/spec/pkg#pkgdep

module Dependabot
  module FileParsers
    module EXPath
      class exist < Dependabot::FileParsers::Base
        require "dependabot/file_parsers/base/dependency_set"
        # require_relative "exist/pkg_parser"

        # The following "dependencies" are candidates for updating:
        # - lib or pkg dependencies
        # - processor dependencies that match semanting version string

        DEPENDENCY_SELECTOR = "dependencies > dependency"

        def parse
          dependency_set = DependencySet.new
          dependency_set += expath_dependencies
          dependency_set.dependencies
        end

        private

        def expath_dependencies
          dependency_set = DependencySet.new
          errors = []
          doc = Nokogiri::XML(expath-pkg.xml.content)
          doc.remove_namespaces!

          # WIP how to select the @package / @version / @semver / @semver-min / @semver-max

          def check_required_files
            return if expath-pkg.xml
            raise "No project expath-pkg.xml descriptor!"
          end
        end
      end
    end
  end
end      
