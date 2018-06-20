# frozen_string_literal: true

require "dependabot/git_commit_checker"
require "dependabot/update_checkers/base"
require "dependabot/shared_helpers"

module Dependabot
  module UpdateCheckers
    module EXPath
      class exist < Dependabot::UpdateCheckers::Base

      # WIP
      def latest_version
        @latest_version ||= fetch_latest_version
      end

      def latest_resolvable_version
        # @processor compatibility
        latest_version
      end

      def latest_resolvable_version_with_no_unlock
        # Irrelevant, since EXpath has a single dependency file
        # For completeness we ought to resolve the pom.xml and return the
        # latest version that satisfies the current constraint AND any
        # constraints placed on it by other dependencies.
        # we just return nil.
        nil
      end

      def updated_requirements
        property_names =
          declarations_using_a_property.
          map { |req| req.dig(:metadata, :property_name) }

        RequirementsUpdater.new(
          requirements: dependency.requirements,
          latest_version: latest_version&.to_s,
          source_url: latest_version_details&.fetch(:source_url),
          properties_to_update: property_names
        ).updated_requirements
      end

      def latest_version_resolvable_with_full_unlock?
        # Full unlock checks aren't implemented for EXPath
        false
      end
    end
  end
end
