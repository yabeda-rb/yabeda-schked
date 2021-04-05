# frozen_string_literal: true

require "schked"
require "yabeda"

require_relative "schked/version"

module Yabeda
  module Schked
    class Error < StandardError; end

    LONG_RUNNING_JOB_RUNTIME_BUCKETS = [
      0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10, # standard (from Prometheus)
      30, 60, 120, 300, 1800, 3600, 21_600 # Schked jobs may be very long-running
    ].freeze

    def self.job_name(job)
      name = job.name || job.opts[:as]
      return name if name

      warn "❗Warning: No name specified for the job #{job.id}, using `'none'` as default."
      "none"
    end

    Yabeda.configure do
      group :schked

      counter :jobs_executed_total,
        tags: %i[name success],
        comment: "A counter of the number of jobs executed."

      histogram :job_execution_runtime,
        comment: "A histogram of the job execution time.",
        unit: :seconds,
        per: :job,
        tags: %i[name success],
        buckets: LONG_RUNNING_JOB_RUNTIME_BUCKETS
    end

    ::Schked.config.register_callback(:after_finish) do |job|
      labels = {success: !job.opts[:failed], name: job_name(job)}
      Yabeda.schked.job_execution_runtime.measure(labels, job.last_work_time.round(3))
      Yabeda.schked.jobs_executed_total.increment(labels)
    end

    ::Schked.config.register_callback(:on_error) do |job|
      job.opts[:failed] = true
    end
  end
end
