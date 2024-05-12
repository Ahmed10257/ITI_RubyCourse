class Bank
    def process_transaction(transactions,cb_block)
        raise NotImplementedError, 'Subclasses must implement abstract method'
    end
end
