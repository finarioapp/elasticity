module Elasticity
  class HadoopStreamingStep

    include Elasticity::JobFlowStep

    attr_accessor :name
    attr_accessor :action_on_failure
    attr_accessor :files_path
    attr_accessor :input_bucket
    attr_accessor :output_bucket
    attr_accessor :mapper
    attr_accessor :reducer
    attr_accessor :arguments

    def initialize(files_path, input_bucket, output_bucket, mapper, reducer, *arguments)
      @name = 'Elasticity Hadoop Streaming Step'
      @action_on_failure = 'CANCEL_AND_WAIT'
      @files_path = files_path
      @input_bucket = input_bucket
      @output_bucket = output_bucket
      @mapper = mapper
      @reducer = reducer
      @arguments = arguments || []
    end

    def to_aws_step(job_flow)
      step = Elasticity::CustomJarStep.new('command-runner.jar')
      step.name = @name
      step.action_on_failure = @action_on_failure
      step.arguments = ['hadoop-streaming', '-files', @files_path, '-input', @input_bucket, '-output', @output_bucket, '-mapper', @mapper, '-reducer', @reducer] + @arguments
      step.to_aws_step(job_flow)
    end

  end
end