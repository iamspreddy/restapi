*** Settings ***
Library 	SeleniumLibrary
Library 	Collections

*** Test Cases ***

JQuery Datepicker Date In Past
	Load JQuery Theme Page
	Select Date From DatePicker 	2020-01-01
	Close Browser

JQuery Datepicker Date In Future
	Load JQuery Theme Page
	Select Date From DatePicker 	2024-02-29
	Close Browser

*** Keywords ***
Load JQuery Theme Page
	Open Browser 	https://jqueryui.com/themeroller/	Chrome
	Scroll Element Into View	id:datepicker
	Scroll Element Into View	id:progressbar
	# Capture Page Screenshot

Select Date From DatePicker
	[Arguments] 	${NewDate}
	${NewYear} 	${NewMonth} 	${NewDay}= 	Evaluate    "${NewDate}".split("-")
	${NewMonth}= 	Convert To Integer    ${NewMonth}
	${NewDay}= 	Convert To Integer    ${NewDay}
	Wait Until Keyword Succeeds    1 min	100ms 	Move DatePicker To Year 	${NewYear}
	Wait Until Keyword Succeeds    1 min	100ms 	Move DatePicker To Month 	${NewMonth}
	Click Link    //div[@id="datepicker"]//a[@data-date="${NewDay}"]
	Capture Page Screenshot

Move DatePicker To Year
	[Arguments] 	${NewYear}
	# Capture Page Screenshot
	${CurrYear}= 	DatePicker Current Year
	Run Keyword If 	${NewYear}>${CurrYear} 	DatePicker Click Next Month
	Run Keyword If 	${NewYear}<${CurrYear} 	DatePicker Click Prev Month
	${CurrYear}= 	DatePicker Current Year
	Should Be Equal As Numbers 	${CurrYear} 	${NewYear}
	# Capture Page Screenshot

Move DatePicker To Month
	[Arguments] 	${NewMonth}
	# Capture Page Screenshot
	${CurrMonth}= 	DatePicker Current Month
	Run Keyword If 	${NewMonth}>${CurrMonth} 	DatePicker Click Next Month
	Run Keyword If 	${NewMonth}<${CurrMonth} 	DatePicker Click Prev Month
	${CurrMonth}= 	DatePicker Current Month
	Should Be Equal As Numbers 	${CurrMonth} 	${NewMonth}
	# Capture Page Screenshot


DatePicker Current Year
	# 	//div[@id="datepicker"]//span[@class="ui-datepicker-year"]		# Year
	${DPYear}=	Get Text 	//div[@id="datepicker"]//span[@class="ui-datepicker-year"]
	[Return]	${DPYear}

DatePicker Current Month
	# 	//div[@id="datepicker"]//span[@class="ui-datepicker-month"]		# Month
	@{Months}= 		Create List 	0thMonth 	January 	February	March	April	May	June	July	August	September	October	November	December
	${DPMonth}= 	Get Text 	//div[@id="datepicker"]//span[@class="ui-datepicker-month"]
	${DPNumMonth}= 	Get Index From List 	${Months} 	${DPMonth}
	[Return]	${DPNumMonth}


DatePicker Click Prev Month
	Click Link    //div[@id="datepicker"]//a[@title="Prev"] 	# Prev Month

DatePicker Click Next Month
	Click Link	//div[@id="datepicker"]//a[@title="Next"]	# Next Month