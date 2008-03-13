require File.join(File.dirname(__FILE__), 'spec_helper')

describe Entrails::ActiveRecord::BetterConditions do
  def base
    @base ||= Class.new do
      stub!(:sanitize_sql).and_return('sql')
      stub!(:sanitize_sql_array).and_return('sql')
      extend Entrails::ActiveRecord::BetterConditions
    end
  end
  describe '#sanitize_sql_array_with_better_conditions' do
    it "returns sql representing the intersection of sub-expressions when array contains the logical :and prefix" do
      base.class_eval{ sanitize_sql_array_with_better_conditions([:and, 'exp1', 'exp2']) }.should == '(sql) AND (sql)'
    end
    it "returns sql representing the union of sub-expressions when array contains the logical :or prefix" do
      base.class_eval{ sanitize_sql_array_with_better_conditions([:or, 'exp1', 'exp2']) }.should == '(sql) OR (sql)'
    end
    it "returns sql representing the negation of sub-expressions when array contains the logical :not prefix" do
      base.class_eval{ sanitize_sql_array_with_better_conditions([:not, 'exp']) }.should == 'NOT (sql)'
    end
    it "returns sql representing the negation of the intersection of sub-expressions when array contains the logical :not and :and prefix" do
      base.class_eval{ sanitize_sql_array_with_better_conditions([:not, :and, 'exp1', 'exp2']) }.should == 'NOT ((sql) AND (sql))'
    end
    it "returns sql representing the negation of the union of sub-expressions when array contains the logical :not and :or prefix" do
      base.class_eval{ sanitize_sql_array_with_better_conditions([:not, :or, 'exp1', 'exp2']) }.should == 'NOT ((sql) OR (sql))'
    end
    it "will delegate to sanitize_sql_array_without_better_conditions if the first element is not one of the logical prefixes, Array, or Hash" do
      base.should_receive(:sanitize_sql_array_without_better_conditions).with(['conditions']).and_return('sql')
      base.class_eval{ sanitize_sql_array_with_better_conditions(['conditions']) }.should == 'sql'
    end
    it "will delegate sub-expressions to sanitize_sql" do
      base.should_receive(:sanitize_sql).with('exp').and_return('sanitized')
      base.class_eval{ sanitize_sql_array_with_better_conditions([:not,'exp']) }.should == 'NOT (sanitized)'
    end
  end
  describe '#sanitize_sql_with_better_conditions' do
    it "returns 1=1 for true" do
      base.class_eval{ sanitize_sql_with_better_conditions(true) }.should == '1=1'
    end
    it "returns 1=0 for false" do
      base.class_eval{ sanitize_sql_with_better_conditions(false) }.should == '1=0'
    end
    it "calls the sanitize_sql_without_better_conditions for values other than true and false" do
      base.should_receive(:sanitize_sql_without_better_conditions).with('other').and_return('expected')
      base.class_eval{ sanitize_sql_with_better_conditions('other') }.should == 'expected'
    end
  end
end
