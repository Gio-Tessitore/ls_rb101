# frozen_string_literal: true
VALID_CHOICES = %w[rock paper scissors spock lizard].freeze

def prompt(message)
  Kernel.puts("\n=> #{message}")
end

# this method serves to the print_options method to add spaces and symbols
def print_with_prefix(ra)
  ra.map { |i| " #{[i].join('')}   -" }.join('   ')
end

# I created this method because I wanted to print all
# the options for the game on one line.
# The method iterates through the argument array,
# takes the first letter (initial) of each string element
# of the array and saves it in a new array. If the first letter of the
# next element is already present in the new array, the
# iteration captures the first and second letter together.
# While the iteration do this, the method also
# associates with each initial/s, a second element
# which is the string 'for' and a third element
# which is the whole string that the iteration took the initial from.
# So, it creates an array of subarray formed by three elements each.
# And then it prints them out.

def print_options(ra)
  options = []
  new_ra = []
  i0 = 0
  i1 = 0
  ra.each do
    new_ra << if new_ra.include?(ra[i0][i1])
                ra[i0][i1] + ra[i0][i1 + 1]
              else
                ra[i0][i1]
              end
    options << [new_ra[i0], ' for ', ra[i0]]
    i0 += 1
  end
  prompt("TYPE: #{print_with_prefix(options)}")
end

# making the variable accessible
user_choice = ''

# this method holds the rule of the game and
# grabs the user and the computer values and decides who wins
def who_wins(user, computer)
  who_wins = [%w[rock scissors], %w[paper rock],
              %w[scissors paper], %w[rock lizard],
              %w[lizard spock], %w[spock scissors],
              %w[scissors lizard], %w[lizard paper],
              %w[paper spock], %w[spock rock], %w[rock scissors]]

  if who_wins.include?([user, computer])
    user
  elsif who_wins.include?([computer, user])
    computer
  elsif user == computer
    'tie'
  end
end

# this is the initial prompt
prompt("Welcome to
   Rock, Paper, Scissors, Spock, Lizard! This is a five-set match.
   The first of us that reaches 5 points will win the match.

   Let's play!

   Choose among these elements: #{VALID_CHOICES.join(', ')}")

# This is the outer loop. At the end it will ask you if you want to play again.
loop do
  choice = 0
  user_points = 0
  computer_points = 0

  # this is the middle loop. it counts the points
  loop do
    break if user_points == 5 || computer_points == 5

    # this is the inner loop. it checks if the input is valid
    loop do
      print_options(VALID_CHOICES)
      choice = Kernel.gets.chomp

      # grabs the initial/s a user inputs
      # and translates it in one of the elements in the array
      case choice
      when 'r'
        user_choice = 'rock'
      when 'p'
        user_choice = 'paper'
      when 's'
        user_choice = 'scissors'
      when 'sp'
        user_choice = 'spock'
      when 'l'
        user_choice = 'lizard'
      end

      if VALID_CHOICES.include?(user_choice)
        prompt("Your choice is #{user_choice}")
        break
      else
        prompt('This is not a valid choice!')
      end
    end

    # it is the computer turn to play
    computer_choice = VALID_CHOICES.sample
    prompt("Computer chose #{computer_choice}")

    # here we add the points
    if who_wins(user_choice, computer_choice) == user_choice
      user_points += 1

    elsif who_wins(user_choice, computer_choice) == computer_choice
      computer_points += 1
    else
      prompt('It´s a tie')
    end

    # it prompts the result of each set
    prompt("You have #{user_points} point/s")
    prompt("Computer has #{computer_points} point/s")
  end

  # it prompts the final result
  if user_points == 5
    prompt("Congratulations! You won the match.")

  elsif computer_points == 5
    prompt("Sorry, computer won the match.")

  end

  prompt("would you like to play again? ['Y', 'n']")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
