require "rexml/document"
require "date"

current_path = File.dirname(__FILE__)
file_name = current_path + "/expenses.xml"
abort "Файл не знайдено" unless File.exist?(file_name)

file = File.new(file_name, "r:UTF-8")
doc = REXML::Document.new(file)
file.close  
puts 'На що була витрата?'
expense_text = gets.chomp
puts 'Скільки витратили?'
expense_amount = gets.chomp
puts 'Коли виконати витрату?'
date_input = gets.chomp
if date_input == ''
	date_input = Date.today 
else 
	date_input = Date.parse(date_input)
end 

puts 'До якої категорії відноситься витрата?'
expense_category = gets.chomp

expenses = doc.elements.find('expenses').first
expense = expenses.add_element 'expense', {
	'date' => date_input.to_s,
	'category' => expense_category,
	'amount' => expense_amount
}
expense.text = expense_text
file = File.new(file_name, "w:UTF-8")
doc.write(file, 2)
file.close
puts 'Запис збережено)))'