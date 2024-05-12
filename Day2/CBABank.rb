require './Logger.rb'

class CBABank < Bank
  def initialize(users)
    @name = 'CBA Bank'
    @users = users
  end
  # Implement the abstract method, it takes a transaction array and a callback block
  def process_transaction(transactions,cb_block)
    # Loop through the transactions
    transactions.each do |transaction|
    # Check if the user is in the bank
    if @users.include? transaction.user
      begin
        transaction.user.balance += transaction.value
        # Check if the user has a negative balance
        if transaction.user.balance < 0
          puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} failed with message Not enough balance"
          message=cb_block.call('errorBalance',transaction)
          Logger::log_error(message)
        # Check if the user has a balance of 0
        elsif transaction.user.balance == 0
          puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value} succeeded"
          message=cb_block.call('success',transaction)
          Logger::log_info(message)
          message=cb_block.call('warning',transaction)
          Logger::log_warning(message)
        # If the user has a positive balance
        else
          puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value} succeeded"
          message=cb_block.call('success',transaction)
          Logger::log_info(message)
        end
      end
    # If the user is not in the bank
    else
      puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{transaction.user.name} not exist in the bank!!"
      message=cb_block.call('errorUser',transaction)
      Logger::log_error(message)
    end
  end
end
end
