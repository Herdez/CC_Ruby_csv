#leer y sobreescribir información en archivo con formato CSV

#'faker' and 'csv' are required
require 'faker'
require 'csv'

#it receives attributes of person
class Person
	#read and write attributes
	attr_accessor :first_name, :last_name, :email, :phone, :created_at
  
  #it initializes 'Person' class
  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end

end


#it generates random attributes of person
def fake_person
	first_name = Faker::Name.first_name 
	last_name = Faker::Name.last_name
	email = Faker::Internet.email
	phone = Faker::PhoneNumber.cell_phone
	created_at = Time.now
	#it creates an object with random attributes
	Person.new(first_name, last_name, email, phone, created_at)
end

#it creates an Array of objects person
def people(num)
	people = []
	num.times do
		people << fake_person
	end
	people
end

#it creates csv file
class PersonWriter
  #it initializes 'PersonWriter' class
	def initialize(file, people_array)
		@file = file
		@people_array = people_array
	end

  #'csv' file is created with attributes of object
	def create_csv
		CSV.open(@file, "wb") do |csv|
  		@people_array.each do |person|
  		  csv << [person.first_name, person.last_name, person.email, person.phone, person.created_at]
  		end
		end
	end
end

#it reads 'csv' file
class PersonParser
	#it initializes 'PersonParser' class
	def initialize(str_file)
    @str_file = str_file
	end
  
  #it creates an instance of object 'person'
	def parser_file
		people_list = []
		CSV.foreach(@str_file) do |row|
       people_list << Person.new(row[0], row[1], row[2], row[3], row[4])
    end
    people_list[0..9]
	end
end



#Driver code

person_writer = PersonWriter.new("people.csv", people(20))
person_writer.create_csv
parser = PersonParser.new('people.csv')
people = parser.parser_file

p people

person = people[0]
person.first_name = "abel"

puts "Person: #{person.inspect}"
p person.first_name


