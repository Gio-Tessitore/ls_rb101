# frozen_string_literal: true

VALID_CHOICES = %w[rock paper scissors].freeze
def prompt(message)
  Kernel.puts("=> #{message}")
end

def who_wins(user, computer)
  who_wins = [%w[rock scissors], %w[paper rock],
              %w[scissors paper]]

  if who_wins.include?([user, computer])
    user
  elsif who_wins.include?([computer, user])
    computer
  elsif user == computer
    'tie'
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets.chomp

    if VALID_CHOICES.include?(choice)
      prompt("Your choice is #{choice}")
      break
    else
      prompt('This is not a valid choice!')
    end
  end

  computer_choice = VALID_CHOICES.sample
  prompt("Computer chose #{computer_choice}")

  # Walk-through: Rock Paper Scissors question number 3
  if who_wins(choice, computer_choice) == choice
    prompt('You win!')
  elsif who_wins(choice, computer_choice) == computer_choice
    prompt('Sorry, computer wins!')
  else
    prompt('It´s a tie')
  end

  prompt("would you like to play again? ['Y', 'n']")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
