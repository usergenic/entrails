require File.join(File.dirname(__FILE__), 'spec_helper')

describe Entrails::ActiveRecord::FindByAssociation do

  def base
    @base ||= Class.new do
      stub!(:with_scope).and_return(nil)
      stub!(:sanitize_sql).and_return('sql')
      stub!(:sanitize_sql_array).and_return('sql')
      stub!(:sanitize_sql_hash).and_return('sql')
      extend Entrails::ActiveRecord::FindByAssociation
    end
  end

  describe "#construct_find_by_association_conditions_sql" do
    it "delegates to construct_find_by_association_conditions_nil_condition_sql when conditions is nil"
    it "delegates to construct_find_by_association_conditions_nil_condition_sql when conditions is an empty Array"
    it "delegates to construct_find_by_association_conditions_nil_condition_sql when conditions is an Array that contains a nil"
    it "does not delegate to construct_find_by_association_conditions_subquery_sql when conditions is nil"
    it "does not delegate to construct_find_by_association_conditions_subquery_sql when conditions is an empty Array"
    it "does not delegate to construct_find_by_association_conditions_subquery_sql when conditions is an Array that contains only nils"
  end

  describe "#sanitize_sql_hash_with_find_by_association" do
    it "calls original sanitize_sql_hash with a hash containing all keys that are *not* association names"
    it "calls construct_find_by_association_sql for each key that is an association name"
    it "calls reflect_on_association for each key to determine whether a it is an association name" do
      mock_association = mock('association', :options => {}, :klass => 'class')
      base.should_receive(:construct_find_by_association_conditions_sql).with(mock_association, 'conditions', :type => 'class')
      base.should_receive(:reflect_on_association).with(:friends).exactly(:once).and_return(mock_association)
      base.should_receive(:reflect_on_association).with(:name).exactly(:once).and_return(nil)
      hash = { :name => 'alice', :friends => 'conditions' }
      base.__send__(:sanitize_sql_hash_with_find_by_association, hash)
    end
  end

end