# frozen_string_literal: true

require "dependabot/file_fetchers/base"

module Dependabot
  module FileFetchers
    module EXPath
      class exist < Dependabot::FileFetchers::Base

        # still missing: expath-pkg.xml.tmpl xar-assembly.xml
        def self.required_files_in?(filenames)
          filenames.include?("expath-pkg.xml")
        end

        def self.required_files_message
          "Repo must contain an expath-pkg.xml descriptor."
        end

        private

        def fetch_files
          fetched_files = []
          fetched_files << expath-pkg.xml
          fetched_files
        end

        def expath
          @expath ||= fetch_file_from_host("expath-pkg.xml")
        end
      end
    end
  end
end
