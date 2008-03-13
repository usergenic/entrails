# Was toying with calling this SexyConditions, since its basically about extending the
# use of Arrays as ActiveRecord finder conditions, to serve as symbolic expressions ala
# Lisp, (hence the Sex in S-Expression,) but frankly the name BetterConditions has been
# in use in our shop's vocabulary since it was created, and it stuck.
#
# So what exactly does this do?  It enables you to construct nested logical expressions
# using symbolic prefix notation, such that [:and, 'condition1', 'condition2'] produces
# the fragment "(condition1) AND (condition2)".  Since it delegates back to sanitize_sql
# it plays nicely with other extensions, like find_by_association as well as nesting ala...
#
#   [:and, [:or, [:not, {:status => 'suspended'}], {:username => 'root'}]], {:pass => "123"}]]
#
# to produce something like the following SQL partial for conditions...
#
#   ((NOT (status='suspended')) OR (username='root')) AND (pass='123')
#
module Entrails::ActiveRecord::BetterConditions
  
  protected
  
  # Allows arrays to represent logical symbolic expressions by use of the
  # symbols :and, :or, and :not and the embedding of nested array and hash
  # conditions.
  def sanitize_sql_array_with_better_conditions(array)
    conditions = []
    joiner = 'OR'
    negate = false
    index = 0
    array.each_with_index do |element, index|
      case element
      when :and, 'and' : joiner = 'AND'
      when :or,  'or'  : joiner = 'OR'
      when :not, 'not' : negate = !negate
      else
        return sanitize_sql_array_without_better_conditions(array) if index == 0
        conditions << sanitize_sql(element)
      end
    end
    return if conditions.empty?
    sql = (conditions.size==1) ? conditions.first : "(#{conditions.join(") #{joiner} (")})"
    sql = "NOT (#{sql})" if negate
    sql
  end

  # Allows true or false to be used as a convenience to short-circuit conditional
  # branches.  
  def sanitize_sql_with_better_conditions(object)
    case object
    when true  : '1=1'
    when false : '1=0'
    else sanitize_sql_without_better_conditions(object)
    end
  end

  def self.extended(host)
    super
    class << host
      alias_method_chain :sanitize_sql, :better_conditions
      alias_method_chain :sanitize_sql_array, :better_conditions
    end
  end
  
end
