require_relative 'user'
require_relative 'transaction'
require_relative 'bank'
require_relative 'cbabank'
require_relative 'logger'

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100),
  User.new("Ahmed", 1000)
]

out_side_bank_users = [
  User.new("Menna", 400),
  User.new("Mina", 300),
  User.new("Mona", 200),
  User.new("Mona", 100)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]
#================================================================================================
cb_block = Proc.new do |status,transaction|
  case status
  when 'errorBalance'
    "User #{transaction.user.name} transaction with value #{transaction.value} failed with message Not enough balance"
  when 'success'
    "User #{transaction.user.name} transaction with value #{transaction.value} succeeded"
  when 'warning'
    "User #{transaction.user.name} has 0 balance"
  when 'errorUser'
    "User #{transaction.user.name} transaction with value #{transaction.value} failed with message Menna not exist in the bank!!"
  end

end

CBA_Bank=CBABank.new(users)
CBA_Bank.process_transaction(transactions,cb_block)
