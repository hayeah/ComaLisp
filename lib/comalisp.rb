class ComaLisp
  def initialize(opts={})
    # parent is used for scoping
    @parent = opts[:parent]
    @env = opts[:env] || {}
  end

  # we use array to represent list and cons
  # The implication is that all lists must be proper. That is (cons 1, 2) is invalid.
  # [] is the empty list. Nothing else is the empty list. It is the fixpoint for cdr.
  def cons(head,tail=nil)
    [head,*tail]
  end

  def consp(o)
    o.is_a? Array
  end

  def tail(lst)
    lst.last
  end
  
  def car(lst)
    return null if lst.size < 1
    lst[0]
  end

  def null
    []
  end

  def nullp(list)
    list == null
  end
  
  def cdr(lst)
    return [] if lst.size == 0
    lst[1..-1]
  end

  def list(*args)
    args
  end

  def call(fn,*args)
    self.instance_exec(*args,&fn)
  end

  def apply(fn,args)
    self.instance_exec(*args,&fn)
  end

  def let(*vars,&body)
    env = vars.inject({}) {|acc,(k,v)|
      acc[k] = v
      acc
    }
    scope(env,&body)
  end

  def scope(env={},&body)
    scope = ComaLisp.new(:parent => self, :env => env)
    scope.instance_eval(&body)
  end

  def defun(argslist,&body)
    me = self
    name = argslist.shift
    eigenclass = class << self; self; end
    eigenclass.instance_eval do
      define_method(name) do |*vals|
        env = {}
        argslist.each_with_index do |arg,i|
          env[arg] = vals[i]
        end
        me.scope(env,&body)
      end
    end
  end

  def set(var,val)
    @env[var.to_sym] = val
  end

  private

  def method_missing(name,*args,&block)
    if args.empty?
      variable_lookup(name)
    else
      method_call(name,*args,&block)
    end
  end

  # we assume the first argument is the receiver
  def method_call(method,receiver,*args,&block)
    receiver.send(method,*args,&block)
  end
  
  def variable_lookup(name)
    if @env.has_key?(name)
      @env[name]
    elsif @parent
      @parent.send(name)
    else
      raise "no binding for #{name}"
    end
  end

  alias_method :eval, :instance_eval
end

def ComaLisp(&block)
  ComaLisp.new.eval(&block)
end
