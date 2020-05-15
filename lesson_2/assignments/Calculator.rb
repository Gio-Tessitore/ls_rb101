REGEX = /\A[+-]?\d+(\.[\d]+)?\z/
# to remove the zero when alone
def str_zero(n)
  n.to_s.sub(/\.?0+$/, '')
end

# Method to print rocket before every message
def message(message)
  Kernel.puts("=>   #{message}")
end

require 'yaml'

message("Please choose your language: EN - IT - ES")
language = Kernel.gets().chomp().downcase()

case language
when 'en'
  TEXT = YAML.load_file('text_keys.yml')
when 'it'
  TEXT = YAML.load_file('text_keys-IT.yml')
when 'es'
  TEXT = YAML.load_file('text_keys-ES.yml')
end

# This method checks if the number is a valid number
def number?(num)
  loop do
    if !REGEX.match(num)
      message(TEXT['real'])
      num = Kernel.gets().chomp()
    else
      break
    end
  end
  num
end

# This is method is to check if the input number is different from zero
def zero?(num)
  number_prompt = TEXT['num_prompt']

  loop do
    break if (num.to_i) != 0
    message(number_prompt)
    ans = Kernel.gets().chomp()

    if ans.start_with?('y')
      num = 0
      break
    elsif ans.start_with?('n')
      message(TEXT['no_zero'])
      num = Kernel.gets().chomp()
      num = number?(num)
    end
  end

  num
end

def validate_operator(op)
  loop do
    validator = %w(1 2 3 4)
    if validator.include?(op)
      return op
    else
      message(TEXT['val_op'])
      op = Kernel.gets().chomp()
    end
  end
end

def operation_to_message(operator)
  case operator
  when '1'
    message(TEXT['add'])
  when '2'
    message(TEXT['sub'])
  when '3'
    message(TEXT['mult'])
  when '4'
    message(TEXT['div'])
  end
end

name = ''
loop do
  message(TEXT['name'])
  name = Kernel.gets().chomp()
  break unless name.empty?()
  message(TEXT['nothing'])
end

message("#{TEXT['hello']} #{name} #{TEXT['welcome']}")

loop do # loop to make a new calculation
  message(TEXT['first_num'])
  num = Kernel.gets().chomp()
  number1 = zero?(number?(num))

  message(TEXT['second_num'])
  num = Kernel.gets().chomp()
  number2 = zero?(number?(num))

  operator_prompt = TEXT['op_prompt']

  message(operator_prompt)
  operator = Kernel.gets().chomp()
  valid_operator = validate_operator(operator)

  # Calculate the total and print out
  result = (case valid_operator
            when '1'
              number1.to_f() + number2.to_f()
            when '2'
              number1.to_f() - number2.to_f()
            when '3'
              number1.to_f() * number2.to_f()
            when '4'
              number1.to_f() / number2.to_f()
            end)

  # This is to write the final answer
  message("#{operation_to_message(valid_operator)}#{number1} #{TEXT['and']} #{number2}
     #{TEXT['give']} #{str_zero(result)} #{TEXT['res']}.")

  message(TEXT['new_cal'])
  answer = Kernel.gets().chomp().downcase()
  break unless answer.start_with?('y')
end

message(TEXT['thanks'])
