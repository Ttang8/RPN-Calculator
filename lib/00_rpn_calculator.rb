class RPNCalculator

  def initialize
    @stack = []
  end

  def push(num)
    @stack << num
  end

  def value
    @stack.last
  end

  def plus
    do_math(:+)
  end

  def minus
    do_math(:-)
  end

  def divide
    do_math(:/)
  end

  def times
    do_math(:*)
  end

  def tokens(string)
    tokens = string.split
    tokens.map { |ch| operation?(ch) ? ch.to_sym : ch.to_i}
  end

  def evaluate(string)
    tokens = tokens(string)

    tokens.each do |token|
      case token
      when Integer
        push(token)
      when Symbol
        do_math(token)
      end
    end

    value
  end

  private #relied on by other methods but not called on externaly

  def operation?(ch)
    [ :+, :-, :*, :/].include?(ch.to_sym)
  end

  def do_math(operand)
    raise "calculator is empty" if @stack.length < 2
    second_operand = @stack.pop
    first_operand = @stack.pop

    case operand
    when :+
      @stack << first_operand + second_operand
    when :-
      @stack << first_operand - second_operand
    when :*
      @stack << first_operand * second_operand
    when :/
      @stack << first_operand.fdiv(second_operand)
    end
  end

end
