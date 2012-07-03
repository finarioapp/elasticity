describe Elasticity::InstanceGroup do

  its(:count) { should == 1 }
  its(:type) { should == 'm1.large' }
  its(:market) { should == 'ON_DEMAND' }
  its(:name) { should == 'Elasticity Instance Group' }
  its(:role) { should == 'CORE' }

  describe '#count=' do

    it 'should set the count' do
      subject.count = 10
      subject.count.should == 10
    end

    context 'when the role is not MASTER' do
      context 'and the count is <= 0' do
        it 'should be an error' do
          subject.role = 'CORE'
          expect {
            subject.count = 0
          }.to raise_error(ArgumentError, 'Instance groups require at least 1 instance (0 requested)')
        end
      end
    end

    context 'when the role is MASTER' do
      context 'and a count != 1 is attempted' do
        it 'should be an error' do
          subject.role = 'MASTER'
          expect {
            subject.count = 2
          }.to raise_error(ArgumentError, 'MASTER instance groups can only have 1 instance (2 requested)')
        end
      end
    end

  end

end