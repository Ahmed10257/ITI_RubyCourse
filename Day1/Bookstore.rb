
begin
values = []
    File.readlines('database.txt').each { |line| values << String(line) }
    puts values
end
#---------------------------------------------------------------------------------------------------
class Book
    #Setters and Getters
    attr_accessor :title, :author, :ISBN
    #Class Variables
    @@id = 0
    #Constructor
    def initialize(title, author, isbn)
        @title = title
        @author = author
        @ISBN = isbn
        @id = @@id
        @@id += 1
   
    end
end

class Inventory
    #Setter and Getters
    attr_accessor :books
    #Class Variables
    @@books = []
    #Constructor
    def add_book(title, author, isbn)
        book = Book.new(title, author, isbn)
        @@books << book
    end

    def get_books
        @@books
    end

end
myInventory = Inventory.new
myInventory.add_book("Book1", "Ahmed", "32132131")
myInventory.add_book("Book2", "Ahmed", "6546843465")
mybooks= myInventory.get_books
File.write("database.txt", mybooks, mode: "a")

