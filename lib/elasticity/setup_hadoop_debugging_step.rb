module Elasticity

  class SetupHadoopDebuggingStep < CustomJarStep

    def initialize
      @name = 'Elasticity (patched) Setup Hadoop Debugging'
      @jar = 'command-runner.jar'
      @arguments = ['state-pusher-script']
      @action_on_failure = 'TERMINATE_JOB_FLOW'
    end

  end

end
