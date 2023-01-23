require "rexml/document"
require "date"
current_path = File.dirname(__FILE__)
file_name = current_path + "/expenses.xml"
abort "Файл не знайдено" unless File.exist?(file_name)

file = File.new(file_name)
doc = REXML::Document.new(file)#створює копію xml
amout_by_day = Hash.new#створює асофційний масив 
doc.elements.each("expenses/expense") do |item|#цикл по всім елементам дерева
	loss_sum = item.attributes["amount"].to_i#шукає витрати в вокументі 
	loss_date = Date.parse(item.attributes["date"])#шукає дату в документі 
	amout_by_day[loss_date] ||=0 #створює асоціацію і приймає значення за 0
	amout_by_day[loss_date] += loss_sum #додає до значення 
end
file.close 

sum_by_month = Hash.new
current_month = amout_by_day.keys.sort[0].strftime("%B %Y")
amout_by_day.keys.sort.each do |key|
	sum_by_month[key.strftime("%B %Y")] ||=0
	sum_by_month[key.strftime("%B %Y")] += amout_by_day[key] 
end

puts "___ #{current_month}, витрата становить #{sum_by_month[current_month]}грн."# виводить рядок з витратитами за місяць
amout_by_day.keys.sort.each do |key|#цикл по масиву
	if key.strftime("%B %Y") != current_month# перевіряє місяць з ключем 
		current_month = key.strftime("%B %Y")#змінює місяць на новий ключ 
		puts "___ #{current_month}, витрата становить #{sum_by_month[current_month]}грн."#виводить рядок з витратами за місяць 
	end 
	puts "\t#{key.day}: #{amout_by_day[key]}грн."#виводить рядок з днем витрати і розміром витрати 
end 