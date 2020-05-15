# variables names
# ann_percent -> Annual Percentage Rate as input
# ann_int_rate -> Annual Percentage Rate in decimals
# mon_int_rate -> monthly interest rate
# loan_duration -> number of payments ( or loan duration in months )
# loan_amount -> amount of money to borrow

# number check reg.expression
LOAN_AMOUNT = /\A[1-9]([0-9]{0,2})(\,\d{3})*(\.\d+)?\z/
PERCENT = /\A[1-9]([0-9]{0,1})(\.\d+)?\z/
MONTH = /\A([1-9]|10|11|12)\z/

# check correct input for loan amount
def check_loan_amount(num)
  loop do
    if !LOAN_AMOUNT.match(num)
      message(MC['num_prompt_loan'])
      num = Kernel.gets().chomp()
    else
      break
    end
  end
  num
end

# check correct input for APR
def check_apr_percentage(num)
  loop do
    if !PERCENT.match(num)
      message(MC['num_prompt_percent'])
      num = Kernel.gets().chomp()
    else
      break
    end
  end
  num
end

# check correct input for month
def check_month(num)
  loop do
    if !MONTH.match(num)
      message(MC['num_prompt_month'])
      num = Kernel.gets().chomp()
    else
      break
    end
  end
  num
end

# Convert APR to monthly interest rate
def year_to_month_rate_convert(apr_in_decimals, loan_duration)
  ((1 + (apr_in_decimals / loan_duration))**loan_duration) - 1
end

# Calculate monthly payment
def calculate_monthly_payment(loan_amount, int_rate, loan_duration)
  loan_amount * (int_rate / (1 - (1 + int_rate)**(-loan_duration)))
end

def comma_separated(num)
  new_num = num.to_s.split('.')
  new_num[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  (new_num.join('.'))
end

def convert_to_percent(num)
  num *= 100
end

# link to text keys file
require 'yaml'
MC = YAML.load_file('mortgage_calculator_text_keys.yml')

# convert everything to string
def message(message)
  Kernel.puts(message.to_s)
end

# Welcome to the Mortgage_calculator
message(MC['welcome'])

# request loan amount, check sequence of digits, add commas
message(MC['amount'])
loan_amount_get = Kernel.gets().chomp()
loan_amount = (check_loan_amount(loan_amount_get))
loan_amount = (loan_amount.gsub(/[,]/, "")).to_i

# request APR
message(MC['apr'])
get_apr = Kernel.gets().chomp()
apr_in_decimals = (check_apr_percentage(get_apr)).to_f / 100

# request loan duration
message(MC['month'])
get_loan_duration = Kernel.gets().chomp()
loan_duration = (check_month(get_loan_duration)).to_i

#calculate monthly rate and express it in decimals 
monthly_rate_in_decimals = year_to_month_rate_convert(apr_in_decimals, loan_duration)

#calculate user's monthly payment
monthly_payment = calculate_monthly_payment(loan_amount, monthly_rate_in_decimals, loan_duration)

#convert monthly rate to percentage
month_rate_in_percent = convert_to_percent(monthly_rate_in_decimals)

# Print output: 'monthly payment' at 'monthly interests' for 'number of months'
message(" The monthly payment for a loan amount of $#{comma_separated(loan_amount)}

 is $#{comma_separated(format('%.2f', monthly_payment))},

 at a rate of #{format('%.2f', month_rate_in_percent)}%,

 for #{loan_duration} months.

 You will pay a total of $#{comma_separated(format('%.2f', (monthly_payment * loan_duration)))}")
