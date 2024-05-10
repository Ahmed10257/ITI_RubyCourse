require 'json'
# begin
# books = JSON.parse(File.read("database.txt"))  
# end
#---------------------------------------------------------------------------------------------------
#Classess
#Book Class
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
    def to_json(*options)
    {
      'title' => @title,
      'author' => @author,
      'ISBN' => @ISBN
    }.to_json(*options)
  end
end
#Inventory Class
class Inventory
    #Setter and Getters
    attr_accessor :books
    #Class Variables
    @@books = []
    #Constructor
    def initialize
        if !File.empty?('database.txt')
            @@books = JSON.parse(File.read('database.txt')).map do |book_hash|
                Book.new(book_hash['title'], book_hash['author'], book_hash['ISBN'])
            end
        else
            @@books = []
        end
    end
    #methods
    #Adding a book to the inventory
    def add_book(book)
        @@books.push(book)
    end
    #Getting the books from the inventory
    def get_books
        @@books.map do |book|
            "Title: #{book.title}\nAuthor: #{book.author}\nISBN: #{book.ISBN}\n\n"
        end
    end
    #Removing a book from the inventory
    def remove_book(isbn)
        for i in 0..@@books.length-1
            # puts "ISBN of book at index #{i}: #{@@books[i].ISBN}"
            # puts "ISBN: #{isbn} #{@@books[i].ISBN}"
            # puts (isbn == @@books[i].ISBN)
            if @@books[i].ISBN.strip == isbn.strip
                # puts "ISBN of book at index #{i}: #{@@books[i].ISBN}"
                @@books.delete_at(i)
                break
            end
        end
    end
    #Writing the books array to the database file
    def write_to_file
        File.write("database.txt", @@books.to_json, mode: "w")
    end
end
#---------------------------------------------------------------------------------------------------
myInventory = Inventory.new
#Main Menu
def menu
    puts "---------------------------------"
    puts "Welcome to the Ineventory"
    puts "1- Add Book"
    puts "2- Remove Book by ISBN"
    puts "3- List Books"
    puts "4- Save and Exit"
end
#Printing the Menu
menu
#Getting the choice from the user
choice=gets
choice=choice.strip
#Checking the choice
while choice 
    case choice
    when "1"
        #Taking the book's details
        puts "Enter Book Title"
        title = gets
        puts "Enter Book Author"
        author = gets
        puts "Enter Book ISBN"
        isbn = gets
        #Creating the book object
        book = Book.new(title, author, isbn)
        #Adding the book to the inventory
        myInventory.add_book(book)
        puts "Book Added"
    when "2"
        puts "Enter Book ISBN"
        isbn = gets
        isbn = isbn.strip
        #Removing the book from the inventory
        myInventory.remove_book(isbn)
        puts "Book Removed"
    when "3"
        #Listing the books
        myInventory.get_books.each do |book|
            puts book
        end
    when "4"
        #Saving the books array to the database file
        myInventory.write_to_file
        exit
    else
        #Invalid Choice Message
        puts "Invalid Choice, Please Enter a Valid Choice"
    end 
    #Reprinting the menu
    menu
    choice=gets
    choice=choice.strip
end
