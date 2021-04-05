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
        Yabeda.schked.jobs_executed_total.values.clear
        Yabeda.schked.job_execution_runtime.values.clear

        job.trigger_off_schedule

        expect(Yabeda.schked.jobs_executed_total.values).to include(
          {name: job_name, success: true} => 1
        )
        expect(Yabeda.schked.job_execution_runtime.values).to include(
          {name: job_name, success: true} => kind_of(Numeric)
        )
      end
    end

    context "when job is failed" do
      let(:job_name) { "FailedJob" }

      it "measures called job" do
        Yabeda.schked.jobs_executed_total.values.clear
        Yabeda.schked.job_execution_runtime.values.clear

        job.trigger_off_schedule

        expect(Yabeda.schked.jobs_executed_total.values).to include(
          {name: job_name, success: false} => 1
        )
        expect(Yabeda.schked.job_execution_runtime.values).to include(
          {name: job_name, success: false} => kind_of(Numeric)
        )
      end
    end

    context "when job has no name" do
      let(:job_name) { nil }

      it "measures called job" do
        Yabeda.schked.jobs_executed_total.values.clear
        Yabeda.schked.job_execution_runtime.values.clear

        expect { job.trigger_off_schedule }.to output(
          /Warning: No name specified for the job/
        ).to_stderr
        expect(Yabeda.schked.jobs_executed_total.values).to include(
          {name: "none", success: true} => 1
        )
        expect(Yabeda.schked.job_execution_runtime.values).to include(
          {name: "none", success: true} => kind_of(Numeric)
        )
      end
    end
  end
end
