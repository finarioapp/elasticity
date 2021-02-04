describe Elasticity::SetupHadoopDebuggingStep do

  subject do
    Elasticity::SetupHadoopDebuggingStep.new
  end

  it 'should be a CustomJarStep' do
    expect(subject).to be_a(Elasticity::CustomJarStep)
  end

  it 'should set the appropriate fields' do
    expect(subject.name).to eql('Elasticity (patched) Setup Hadoop Debugging')
    expect(subject.jar).to eql('command-runner.jar')
    expect(subject.arguments).to eql(['state-pusher-script'])
    expect(subject.action_on_failure).to eql('TERMINATE_JOB_FLOW')
  end

end
