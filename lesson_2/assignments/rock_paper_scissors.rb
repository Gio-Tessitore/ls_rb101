# frozen_string_literal: true
VALID_CHOICES = %w[rock paper scissors spock lizard].freeze

def prompt(message)
  Kernel.puts("=> #{message}")
end

# this method serves to the print_options method to add spaces and symbols
def print_with_prefix(options_array)
  options_array.map { |i| " #{[i].join('')}   -" }.join('   ')
end

# The "options" method iterates through the argument array,
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

def options(ra)
  new_ra = []
  options = []
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
  options
end

def print_options(ra)
  prompt("TYPE: #{print_with_prefix(options(ra))}")
end

# making variables accessible
user_choice = ''
valid_choice = ''
get_computer_choice = ''

# this method holds the rule of the game and
# grabs the user and the computer values and decides who wins
def best_player(user, computer)
  best_move = [%w[rock scissors], %w[paper rock],
               %w[scissors paper], %w[rock lizard],
               %w[lizard spock], %w[spock scissors],
               %w[scissors lizard], %w[lizard paper],
               %w[paper spock], %w[spock rock], %w[rock scissors]]

  if best_move.include?([user, computer])
    user
  elsif best_move.include?([computer, user])
    computer
  elsif user == computer
    'tie'
  end
end

# this is the initial prompt
prompt("
   Let's play!

   Choose among these elements: #{VALID_CHOICES.join(', ')}")

# This is the outer loop. At the end it will ask you if you want to play again.
loop do
  user_points = 0
  computer_points = 0

  # this is the middle loop. it counts the points
  loop do
    break if user_points == 5 || computer_points == 5

    # this is the inner loop. it checks if the input is valid

    loop do
      print_options(VALID_CHOICES)
      user_choice = Kernel.gets.chomp

      # grabs the initial/s a user inputs
      # and translates it in one of the elements in the array

      case user_choice
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
        valid_choice = user_choice
        break
      else
        prompt('This is not a valid choice!')
      end
    end

    # it is the computer turn to play
    get_computer_choice = VALID_CHOICES.sample
    computer_choice = get_computer_choice

    prompt("You chose #{valid_choice} and Computer chose #{computer_choice}")

    # here we add the points
    update_score =
      if best_player(user_choice, computer_choice) == user_choice
        user_points += 1
      elsif best_player(user_choice, computer_choice) == computer_choice
        computer_points += 1
      else
        false
      end

    # it prompts the result of each set
    if update_score == false
      prompt("It´s a tie")
    end
    prompt("You: #{user_points} point/s - Computer #{computer_points} point/s")
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
