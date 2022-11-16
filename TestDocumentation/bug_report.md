# Bug Report

Bug report в [Google Таблице](https://docs.google.com/spreadsheets/d/1P9NU0PIWAzhoHew6rp0UjliQeoO1vB7uqCFw2a2fZR8/edit#gid=1947573212)

Чек-лист можно посмотреть [тут](https://github.com/sbrownbear/qa_practice/blob/main/checklist_form_testing.md)

[Тестируемый сайт](http://itcareer.pythonanywhere.com/)

Bug id | id_1
---|---
Title|	Пользователь не может зарегистрироваться с 2 символами в поле "Name"
Severity|	Critical
Priority|	High
Environment	| Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR	| 1. Ввести 2 латинских буквы в поле "Name" (например: Ni) 2. Нажать "Submit"
Actual Result	|Error
Expected Result	|Success
Attachments |
	
	
Bug id|	id_2
---|---
Title|	Пользователь не может зарегистрироваться с 3 символами в поле "Name"
Severity|	Critical
Priority|	High
Environment|	Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR|	1. Ввести 3 латинских буквы в поле "Name" 2. Нажать "Submit"
Actual Result|	Error
Expected Result|	Success
Attachments	|
	
	
Bug id|	id_3
---|---
Title|	Пользователь не может зарегистрироваться с 127 символами в поле "Name"
Severity|	Critical
Priority|	High
Environment|	Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR	|1. Ввести 127 латинских буквы в поле "Name" 2. Нажать "Submit"
Actual Result|	Error
Expected Result|	Success
Attachments	|

Bug id|	id_4
---|---
Title|	Пользователь не может зарегистрироваться с 128 символами в поле "Name"
Severity	|Critical
Priority|	High
Environment	|Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR|	1. Ввести 128 латинских буквы в поле "Name" 2. Нажать "Submit"
Actual Result	|Error
Expected Result	|Success
Attachments	|
	
	
Bug id|	id_5
---|---
Title	|Пользователь может зарегистрироваться с символом & в поле "Name"
Severity|	Critical
Priority|	High
Environment	|Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR	|1. Ввести символ & в поле "Name" 2. Нажать "Submit"
Actual Result|	Success
Expected Result|	Error
Attachments	|
	
	
Bug id	|id_6
---|---
Title|	Пользователь может зарегистрироваться с кириллицой в поле "Name"
Severity|	Critical
Priority	|High
Environment|	Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR|	1. Ввести кириллицу в поле "Name" 2. Нажать "Submit"
Actual Result|	Success
Expected Result|	Error
Attachments|	
	
	
Bug id|	id_7
---|---
Title	|Пользователь не может зарегистрироваться с символом _ в начале в поле "Name"
Severity|	Critical
Priority|	High
Environment|	Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR|	1. Ввести имя со символа _ в поле "Name" 2. Нажать "Submit"
Actual Result	|Success
Expected Result|	Error
Attachments	|
	
	
Bug id|	id_8
---|---
Title|	Пользователь не может зарегистрироваться с символом _ в конце в поле "Name"
Severity|	Critical
Priority|	High
Environment	|Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR|	1. Ввести символ _ в конце имени в поле "Name" 2. Нажать "Submit"
Actual Result|	Success
Expected Result|	Error
Attachments	|
	
	
Bug id|	id_9
---|---
Title|	Пользователь не может зарегистрироваться с 2 символом _ в середине имени в поле "Name"
Severity|	Critical
Priority|	High
Environment	|Windows 10 Домашняя, x64; Google Chrome Версия 102.0.5005.63
Precondition|	Все поля, кроме "Name" заполнены валидными данными
STR	|1. Ввести символ __ в середине имени в поле "Name" 2. Нажать "Submit"
Actual Result|	Success
Expected Result	|Error
Attachments	|