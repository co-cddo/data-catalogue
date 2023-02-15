# frozen_string_literal: true

class SourceSchedulerJob < ApplicationJob
  queue_as :data_service

  def perform
    Source.active.each do |source|
      fetcher_name(source).send(:perform_later, source_id: source.id)
    end
  end

  private

  def fetcher_name(source)
    "#{source.kind}_fetcher_job".camelize.constantize
  end
end
