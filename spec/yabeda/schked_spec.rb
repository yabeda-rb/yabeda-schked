# frozen_string_literal: true

RSpec.describe Yabeda::Schked do
  it "has a version number" do
    expect(Yabeda::Schked::VERSION).not_to be nil
  end

  context "when job is called" do
    let(:worker) { Schked.worker.tap(&:pause) }
    let(:job) { worker.job(job_name) }

    context "when job is successful" do
      let(:job_name) { "SuccessfulJob" }

      it "measures called job" do
        expect { job.trigger_off_schedule }.to \
          increment_yabeda_counter(Yabeda.schked.jobs_executed_total).with_tags(name: job_name, success: true).and \
            measure_yabeda_histogram(Yabeda.schked.job_execution_runtime).with_tags(name: job_name, success: true)
      end
    end

    context "when job fails on first call but succeeds on second" do
      let(:job_name) { "SuccessfulJob" }

      it "measures the job with failure and success" do
        job.opts[:failed] = true

        expect { job.trigger_off_schedule }.to \
          increment_yabeda_counter(Yabeda.schked.jobs_executed_total).with_tags(name: job_name, success: false).and \
            measure_yabeda_histogram(Yabeda.schked.job_execution_runtime).with_tags(name: job_name, success: false)

        expect { job.trigger_off_schedule }.to \
          increment_yabeda_counter(Yabeda.schked.jobs_executed_total).with_tags(name: job_name, success: true).and \
            measure_yabeda_histogram(Yabeda.schked.job_execution_runtime).with_tags(name: job_name, success: true)
      end
    end

    context "when job is failed" do
      let(:job_name) { "FailedJob" }

      it "measures called job" do
        expect { job.trigger_off_schedule }.to \
          increment_yabeda_counter(Yabeda.schked.jobs_executed_total).with_tags(name: job_name, success: false).and \
            measure_yabeda_histogram(Yabeda.schked.job_execution_runtime).with_tags(name: job_name, success: false)
      end
    end

    context "when job has no name" do
      let(:job_name) { nil }

      it "measures called job" do
        expect { job.trigger_off_schedule }.to \
          increment_yabeda_counter(Yabeda.schked.jobs_executed_total).with_tags(name: "none", success: true).and \
            measure_yabeda_histogram(Yabeda.schked.job_execution_runtime).with_tags(name: "none", success: true).and \
              output(/Warning: No name specified for the job/).to_stderr
      end
    end
  end
end
