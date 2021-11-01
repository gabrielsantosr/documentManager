<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
html {
	background-color: #444;
}

body {
	width: 80%;
	min-width: 1303px;
	height: 100vh;
	margin-left: auto;
	margin-right: auto;
	background-color: #111;
}

.title:hover {
	color: blue;
	cursor: pointer;
}

table {
	/* 	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); */
	/* 	table-layout: fixed; */
	/* 	width: 70%; */
	border-radius: 6px;
}

.sectionButton {
	background-color: #444;
	color: #EEE; //
	float: left;
	border-radius: 8px 24px 0 0;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	transition: 0.3s;
}

.active {
	background-color: #6f6f6f;
}
.sectionButton.active{
	border-style: groove groove none groove;
}

tr:nth-child(odd) {
	background-color: #EFEFEF;
}

tr:nth-child(even) {
	background-color: #E0E0E0;
}

td input {
	width: 110px;
	margin: 0;
	padding: 0;
	border: none;
}

.remarked {
	color: blue;
	font-style: italic;
	font-weight: bold;
}

.authorsDropListItem {
	color: black;
	font-style: normal;
	font-weight: normal;
	text-align: left;
}

.listItem {
	text-align: left;
}

.listItem:hover {
	background-color: #ddd;
}

td {
	padding: 10px;
	overflow: hidden;
	text-overflow: ellipsis;
	text-align: left;
}

th {
	padding: 5px;
	text-align: left;
	font-weight: normal;
	letter-spacing: 0.1em;
}

#table tbody tr:last-child td:nth-child(1) {
	border-bottom-left-radius: 6px;
}

/*
#authorsDropInput {
	color: black;
}*/
#authorsDropDiv {
	font-weight: normal;
	text_align: left;
	position: relative;
	width: 100%;
	right: 0;
	padding: 0;
	color: #222;
}

/*#referencesContainer div{
}*/
#references {
	margin: 10px 10px;
	padding: 10px 10px;
	background-color: #EFEFEF;
	border-left: 5px solid #00AA00;
	border-radius: 6px;
	height: 20vh;
	overflow: auto;
	position: relative;
	bottom: 10px;
	/* 	opacity:0.5; */
}

.glyphicon {
	margin: 10px;
}

.regularGlyph.enabled {
	color: #0000AA;
	cursor: pointer;
}

.regularGlyph {
	color: transparent;
	cursor: inherit;
}

.removeIcon {
	color: #AA0000;
	cursor: pointer;
}

.okIcon {
	color: #00AA00;
	cursor: pointer;
	margin: 0px;
	padding: 0px;
}

.cont {
	position: relative;
	margin: auto;
	border-radius: 6px;
	background-color: #6f6f6f;

	/* max-width: inherit; */
}

#documentAuthorsTable thead tr /*:not(tr:first-child)*/ {
	/*background-color: #222;*/
	background-image: linear-gradient(to right, #222, #444, #222);
	color: #EEE;
}

/* #documentAuthorsTable thead tr:first-child{ */
/* 	background-image: none; */
/* 	background-color: transparent; */
/* } */
#documentAuthorsTable td:last-child, #documentAuthorsTable th:last-child
	{
	min-width: 122px;
}

#addForm label {
	
}
/* #addForm input:not(#authorsDropInput) { */
/* 	margin: 3px auto; */
/* } */
.formDiv /*:not(#datDiv)*/ {
	margin: 10px 20px;
	width: 180px;
}

.formDiv p:not(#authorsDropList p) {
	margin: 0px 10px;
	text-align: right;
	color: #EEE;
	text-shadow: 1px 1px #222;
	position: relative;
}

.formDiv input, .formDiv select {
	margin: 0 10px 5px 10px;
	width: calc(100% - 20px);
	background-image: linear-gradient(to bottom right, transparent, #777);
	border: none;
	border-radius: 3px;
}

.mandatory {
	position: absolute;
	color: #fa9a3a;
	font-size: 20px;
	font-weight: bold;
	right: 20px;
}

#authorsDropList {
	position: absolute;
	cursor: pointer;
	background-color: #f1f1f1;
	max-height: 0px;
	overflow: auto;
	z-index: 1;
	text-alignment: left;
	opacity: 0.9;
}
</style>

<title>Document Manager</title>
</head>
<body>
	<div id="loading" style="font-size: 80px">LOADING</div>
	<div id="botonera" style="margin: auto" hidden>
		<center>
			<button id="documents">Get Documents</button>
			<button id="addDocument">Add Document</button>
		</center>
	</div>
	<div class="cont" id="formContainer" hidden>
		<form id="addForm" style="">
			<fieldset>
				<legend>New Document</legend>
				<div class="formDiv" style="display: inline-block">
					<p for="docTypeSelector">Document type</p>
					<select name="docType" id="docTypeSelector">
						<option value="0" selected>Select ...</option>
					</select>
				</div>
				<button id="registerButton" style="display: inline-block" disabled>
					Register</button>
				<div id="fields" hidden>
					<span
						style="display: inline-block; box-shadow: 3px 3px 10px #222; border-radius: 3px; position: relative;">
						<div class="formDiv field" id="dateField">
							<p>Date of publication</p>
							<input id="dateInput" type="number" autocomplete="off"
								style="width: 60px; margin: 0 10px 5px calc(100% - 10px - 60px)"
								type="text" />
						</div>
						<div class="formDiv field" id="journalNameField">
							<p for="journalNameInput">Journal name</p>
							<input id="journalNameInput" />
						</div>
						<div class="formDiv field" id="titleField">
							<p for="titleInput">Title</p>
							<input id="titleInput" />
						</div>
						<div class="formDiv field" id="subTitleField">
							<p for="subTitleInput">Sub-title</p>
							<input id="subTitleInput" />
						</div>
						<div class="formDiv field" id="volNumberField">
							<p for="volNumberInput">Volume #</p>
							<input id="volNumberInput" />
						</div>
						<div class="formDiv field" id="volReleaseField">
							<p for="volReleaseInput">Volume release</p>
							<input id="volReleaseInput" />
						</div>
						<div class="formDiv field" id="editionField">
							<p for="editionInput">Edition</p>
							<input id="editionInput" />
						</div>
						<div class="formDiv field" id="publisherField">
							<p for="publisherInput">Publisher</p>
							<input id="publisherInput" />
						</div>
						<div class="formDiv field" id="publisherLocationField">
							<p for="publisherLocationInput">Publisher location</p>
							<input id="publisherLocationInput" />
						</div>
						<div class="formDiv field" id="startPageField">
							<p for="startPageInput">Start page</p>
							<input id="startPageInput" type="number" />
						</div>
						<div class="formDiv field" id="endPageField">
							<p for="endPageInput">End page</p>
							<input id="endPageInput" type="number" />
						</div>
						<div class="formDiv field" id="doiField">
							<p for="doiInput">DOI</p>
							<input id="doiInput" />
						</div>
						<div class="formDiv field" id="sourceField">
							<p for="sourceInput">Source</p>
							<input id="sourceInput" />
						</div>
					</span>
					<div class="formDiv field" id="authorsField"
						style="display: inline-block; position: absolute; width: 470px; margin: 0 0; padding: 10px; box-shadow: 3px 3px 10px #222; border-radius: 3px;">
						<p style="text-align: right; margin: 0 20px;">Authors</p>
						<div id="authorsDropDiv">
							<input id="authorsDropInput" style="width: 180px;" type="text"
								value="Look up author ..." onkeyup="searchAuthor(this.value)"
								autocomplete="off" />
							<div id="authorsDropList"></div>
						</div>
						<table id="documentAuthorsTable"
							style="position: relative; width: 100%;">
							<colgroup>
								<col width="50px" />
								<col width="150px" />
								<col width="150px" />
								<col width="120px" />
							</colgroup>
							<thead>
								<tr class="trans">
									<th colspan="2"></th>
									<th colspan="2"></th>
								</tr>
								<tr>
									<th>ID</th>
									<th>First name</th>
									<th>Last name</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>

			</fieldset>
		</form>
	</div>
	<div id="documentsContainer" class="cont" hidden>
		<span class="glyphicon glyphicon-search"
			style="position: relative; margin: 10px 0px /*4px*/; color: #000; left: /*170px*/ 190px; font-weight: 900;">

		</span> <input id="docSearch"
			style="position: relative; margin: 10px 0px; left: 20px; opacity: 0.5; background-color: white;"
			type="text" onkeyup="search(this)" />

		<div style="position: relative; margin: 10px;">
			<div id="tableScrollableDiv"
				style="display: inline-block; width: 50%; height: 50vh;">
				<div id="headerDiv" style="height: 10%">
					<table style="width: 100%">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="20%" />
							<col width="40%" />
							<col width="10%" />
						</colgroup>
						<thead id="docsHeader">
							<tr>
								<th style="border-top-left-radius: 6px;">ID</th>
								<th>Type</th>
								<th>Authors</th>
								<th>Title</th>
								<th style="border-top-right-radius: 6px;"></th>
							</tr>
						</thead>
					</table>
				</div>
				<div id="dataTableDiv"
					style="width: 100%; height: 90%; overflow-y: scroll; border-radius: 6px;">
					<table id="docsTable" style="width: 100%;">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="20%" />
							<col width="40%" />
							<col width="10%" />
						</colgroup>
						<tbody style="">
						</tbody>
					</table>
				</div>
			</div>
			<div id="previewDiv"
				style="width: calc(50% - 4px); display: inline-block; position: relative;">
				<iframe title="file"
					style="height: 50vh; width: 100%; border-radius: 6px;"></iframe>
				<div class="progress" id="barContainer"
					style="z-index: 10; position: absolute; width: 100%;" hidden>
					<div class="progress-bar" role="progressbar" id="downloadBar"></div>
				</div>
			</div>
		</div>
		<div
			style="color: #EEEEEE; margin: 25px 10px 10px; letter-spacing: 0.2em; padding: 0 10px; font-size: 16px; text-shadow: 1px 1px black">References</div>
		<div id="referencesContainer" style="position: relative; width: 100%;">
			<!-- 			<span id="referencesBackground" style="color:#222; font-weight:900; padding:0 ; position:absolute; letter-spacing: 0.5em;text-align: center;width: 100%; height:100%; font-size:100px;line-height:20vh;">references</span> -->
			<div id="references"></div>
		</div>
	</div>
	</div>

	<script>

var docsTable = document.getElementById("docsTable");
var iframe = document.getElementsByTagName("iframe")[0];
var downloadBar = document.getElementById("downloadBar");
var barContainer = document.getElementById("barContainer");
var authorsDropInput = document.getElementById("authorsDropInput");
var authorsDropList = document.getElementById("authorsDropList");
var documentAuthorsTable = document.getElementById("documentAuthorsTable");
var references = document.getElementById("references");
var lookUpAuthorText = document.getElementById("authorsDropInput").value;
var docTypeSelector = document.getElementById("docTypeSelector");


aDIwidth = authorsDropInput.style.width;
authorsDropInput.style.margin= "0 10px 5px calc(100% - 10px - "+aDIwidth+")";
authorsDropList.style.width= authorsDropInput.style.width;
authorsDropList.style.margin= authorsDropInput.style.margin;
authorsDropInput.addEventListener("focus",function(){
	this.value = "";
	searchAuthor("");
})
loadingTag = document.getElementById("loading");

for (i=0;i<3;i++){
	dotSpan = document.createElement("span");
	dotSpan.hidden = true;
	dotSpan.appendChild(document.createTextNode("."));
	loadingTag.appendChild(dotSpan);
}

loadingDots = loadingTag.getElementsByTagName("span");
loadingDotsLength = loadingDots.length;
currentDotPosition = 0;
var loadingAnimation = setInterval(function(){
		if (currentDotPosition == loadingDotsLength){
			for (dot of loadingDots) dot.hidden = true;
			currentDotPosition = 0;
		}
		else loadingDots[currentDotPosition++].hidden = false;
		},250);


var documents ={
	items : [],
	/*When sorting is requested, if the ordering criteria is the same as in the the previous request,
		sorting will happen in opposite direction. If it is another criteria, it will happen ascendently.
	*/
	order : { 
		id: false,
		docType: false,
		authors: false,
		title: false
	}
	
}




var authors={
	items:[],
	order : {
		id: false,
		firstName: false,
		lastName: false,
	}
}

var docTypes = {
	items:[],
	get: function(id){
		for (item of this.items){
			if (item.id == id) return item;
		}
		return null;
	}
}


	
document.getElementById("addForm").onsubmit= function(){return false};
document.getElementById("registerButton").onclick= registerHandler;
document.onclick = hideContainer;

var enableHideContainer = false;

var sections = {};


class Section {
	constructor (button,container){
		button.addEventListener("click",()=>{buttonHandler(button)});
		button.classList.add("sectionButton");
		container.addEventListener("click",()=>{enableHideContainer = false;});
		this.button = button;
		this.container = container;
	}
}
class SectionB{
	constructor (sectionName){
		this.button = document.createElement("button");
		this.button.id = sectionName;
		this.button.innerHTML = sectionName;
		this.button.addEventListener("click", ()=>{buttonHandler(this.button)});
		this.container = document.createElement("div");
		this.container.addEventListener("click", ()=>{enableHideContainer = false;});
		this.container.style.backgroundColor = "green";
		document.getElementById("botonera").appendChild(this.button);
		document.body.appendChild(this.container);
		sections[sectionName] = this;
	}
}


sections.documents = new Section (document.getElementById("documents"), document.getElementById("documentsContainer"));
sections.addDocument = new Section(document.getElementById("addDocument"), document.getElementById("formContainer"));

function registerHandler(event){
	console.log("REGISTER HANDLER");
	let regDocument={
		docType:docTypes.get(Number(docTypeSelector.value)),	
		year: (dateInput.value)?dateInput.value:null,
		title: (titleInput.value)?titleInput.value:null,
		subTitle: (subTitleInput.value)?subTitleInput.value:null,
		journalName: (journalNameInput.value)?journalNameInput.value:null,
		volume: {volumeNumber:(volNumberInput.value)?volNumberInput.value:null, volumeRelease:(volReleaseInput.value)?volReleaseInput.value:null},
		edition: (editionInput.value)?editionInput.value:null,
		publisher: (publisherInput.value)?publisherInput.value:null,
		publisherLocation: (publisherLocationInput.value)?publisherLocationInput.value:null,
		startPage: (startPageInput.value)?startPageInput.value:null,
		endPage: (endPageInput.value)?endPageInput.value:null,
		doi: (doiInput.value)?doiInput.value:null,
		source: (sourceInput.value)?sourceInput.value:null,
		authors:[]
	}
	
	for (row of documentAuthorsTable.tBodies[0].children){
		if (row.firstChild.firstChild.tagName=="SPAN") continue;
		let author = {};
		author.id = (row.firstChild.innerHTML=="new")?null:Number(row.firstChild.innerHTML);
		author.firstName = row.children[1].innerHTML;
		author.lastName = row.children[2].innerHTML;
		regDocument.authors.push(author);
	}
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange = function(){
		if (ajax.readyState == 4 && ajax.status == 200){
			refreshDocsTable = true;
			console.log("document successfully transferred to server");
			regDocument = JSON.parse(ajax.response);
			console.log(regDocument);
			if (authors.fetched ){
				let authorsIds=[];
				for (author of authors.items){
					authorsIds.push(author.id);
				}
				let authorsSizeBefore = authors.items.length;
				for (author of regDocument.authors){
					if (!authorsIds.includes(author.id)){
						authors.items.push(author);
					}
				}
				refreshAuthorsTable = refreshAuthorsTable || (authors.items.length > authorsSizeBefore);
			}
			postNewDocument(regDocument);
			documentAuthorsTable.tBodies[0].innerHTML = null;
			addedAuthorsIds=[];
			validateAuthorsField();
			docTypeSelector.value = 0;
			docTypeSelector.onchange();
		}
	}
	ajax.open("POST","new_doc",true);
	ajax.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	ajax.send(JSON.stringify(regDocument));
}
console.log("LOADING");

fieldManager={};

fields = document.getElementsByClassName("field");

for (field of fields){
	span = document.createElement("span");
	span.appendChild(document.createTextNode("*"));
	span.classList.add("mandatory");
	field.insertBefore(span, field.firstChild);
	id = field.id;
	fieldName = id.substring(0,id.length-5);
	fieldManager[fieldName]={};
	fieldManager[fieldName].field = field;
	fieldManager[fieldName].star = span;
	fieldManager[fieldName].required= 0;
	fieldManager[fieldName].valid= false;
	
	if 	(	fieldName == "authors" 	||
			fieldName == "date" 	||
			fieldName == "startPage"||
			fieldName == "endPage") {
		continue;
	}
	input = field.getElementsByTagName("input")[0];
	input.addEventListener("focusout",enableRegisterButton);
 	input.addEventListener("keyup",enableRegisterButton);
}

function enableRegisterButton(){
	fieldName = this.id.substring(0,this.id.length-5);
	if (fieldManager[fieldName].required == 1){
		if (this.value.replace(/^\s+|\s+$/g, '')){
			fieldManager[fieldName].valid = true;
		} else{
			fieldManager[fieldName].valid = false;
		}
	} else {
		fieldManager[fieldName].valid = true;
	}
	allFieldsValidation(fieldManager[fieldName].valid);
}

var registerEnabled;

function allFieldsValidation(fieldValid){
	registerEnabled = registerEnabled || false;
	if (registerEnabled){
		registerEnabled = fieldValid;
	} else if (!fieldValid){
		registerEnabled = false;
	} else{
		registerEnabled = true;
		for (each in fieldManager){
			registerEnabled &= (fieldManager[each].valid || fieldManager[each].required == 0);
			if (!registerEnabled) break;
		}
	}
	document.getElementById("registerButton").disabled = !registerEnabled;
}


var minDate = 1200;
var maxDate = new Date().getFullYear();
dateInput = document.getElementById("dateInput");
dateInput.min = minDate;
dateInput.max = maxDate;

startPageInput.min = 0;
startPageInput.onkeypress = watchPages;
endPageInput.onkeypress = watchPages;

startPageInput.onfocusout = pageInputHandler;
endPageInput.onfocusout = pageInputHandler;
startPageInput.oninput = pageInputHandler;
endPageInput.oninput = pageInputHandler;


function watchPages(event){
	target = event.target;
	val = target.value;
	key = event.which || event.keyCode;
	console.log(key)
	if (key < 48 || key > 57) return false;
	
}

function pageInputHandler(event){
	endPageInput.min = startPageInput.value;
	startPageInput.max = endPageInput.value;
	fieldManager.endPage.valid = (endPageInput.value >= startPageInput.value);
	fieldManager.startPage.valid = (endPageInput.value >= startPageInput.value);
	allFieldsValidation(fieldManager.endPage.valid);
}

dateInput.onkeypress = watchDate;

dateInput.oninput = dateInputHandler;/*in case copy+paste */
//dateInput.onkeyup = dateInputHandler;/*in case copy+paste */
dateInput.onfocusout = function(event){
	if (this.value.length != 4)
		this.value = "";
	dateInputHandler(event);
};

function dateInputHandler(event){
	target = event.target;
	val = target.value;
	//console.log("triggered by input event. VALUE:"+val);
	if (val.length >3){
		target.value = (val<minDate)?minDate:((val>maxDate)?maxDate:val)
	}
	fieldManager.date.valid = (target.value >= minDate && target.value <= maxDate);
	allFieldsValidation(fieldManager.date.valid);
}

function watchDate(event){
	//console.log("triggered by keypress event")
	target = event.target;
	val = target.value;
	key = event.which || event.keyCode;
	if (key>=48 && key <=57){
		if (val.length == 3){
			newVal = val + String.fromCharCode(key);
			if (newVal< minDate){
				event.target.value = minDate;
				return false;
			} else if (newVal > maxDate){
				event.target.value = maxDate;
				return false;
			}
		} else if (val.length > 3) return false;
	} else return false;
}




function getScrollBarWidth(){
	let sDiv = document.createElement("div");
	document.body.appendChild(sDiv);
	sDiv.style.overflow="scroll";
	let barWidth = sDiv.offsetWidth-sDiv.clientWidth;
	document.body.removeChild(sDiv);
	return barWidth;
}

headerDiv=document.getElementById("headerDiv");
barWidth = getScrollBarWidth();
arg = "calc(100% - "+barWidth+"px)";
headerDiv.style.width=arg;


var enableHideDocumentsContainer;
documentsContainer = document.getElementById("documentsContainer");
documentsContainer.addEventListener("click",function(){enableHideDocumentsContainer = false;});

function getDocuments(){
	dc = documentsContainer;
	dc.hidden = !dc.hidden;
	if (!dc.hidden){//If turned from hidden to visible.
		/*Setting enableHideDocumentsContainer to false prevents the bubbling of the click
		that triggered the execution of this function from hiding the documents container.*/
		enableHideDocumentsContainer = false;
		document.addEventListener("click",hideDocuments);
	} else {//If turned from visible to hidden.
		document.removeEventListener("click",hideDocuments);
	}
}
///////////////////////////////////////////////////////////////////////////////////
//This method is an attempt to integrate all the sections button-handlers. It is not yet deployed.
function buttonHandler(target){
	for (section in sections){
		let currentSection = sections[section];
		let container = currentSection.container;
		let button = currentSection.button;
		
		if (section == target.id){
			 container.hidden = !container.hidden;
			 if(!container.hidden){
				 enableHideContainer = false;
				 button.classList.add("active");
			 } else {
				 button.classList.remove("active");
			 }
		} else {
			container.hidden = true;
			button.classList.remove("active");
		}
	}
}

function hideContainer(target){
	if (enableHideContainer){
		for(section in sections){
			let currentSection = sections[section];
			let container = currentSection.container;
			let button = currentSection.button;
			if (!container.hidden){
				container.hidden = true;
				button.classList.remove("active");
			}
		}
	} else{
		enableHideContainer = true;
	}
}

/////////////////////////////////////////////////////////////////////////////////
function hideDocuments(){
	dc = documentsContainer;
	if(enableHideDocumentsContainer){
		dc.hidden = true;
		document.removeEventListener("click",hideDocuments);
	} else{
		enableHideDocumentsContainer = true;
	}
}

refreshDocsTable = true;

function search(target){
	searchArray = keyWordArrayGenerator(target.value);
	refreshDocsTable = true;
	for (doc of documents.items){
		str = doc.title+" ";
		for (author of doc.authors){
			str+= author.lastName+ " "+author.firstName+" ";
		}
		str = str.toLowerCase();
		allWordsMatched = true ;
		for (searchWord of searchArray){
			if (!allWordsMatched) break;
			allWordsMatched = allWordsMatched && str.includes(searchWord);
		}
		doc.display = allWordsMatched;
	}
	fillDocsTable();
}

emptyAuthor = {
		id: 0,
		firstName: null,
		lastName: null
}
function searchAuthor(text){
	authorsDropList.innerHTML = null;
	div = document.createElement("div");
	div.classList.add('listItem');
	dataP = document.createElement("p");
	dataP.hidden = true;
	dataP.innerHTML = JSON.stringify(emptyAuthor);
	p = document.createElement("p");
	p.classList.add("remarked");
	p.innerHTML= "new author";
	p.addEventListener("click",appendToAuthorsTable,false);
	div.appendChild(dataP);
	div.appendChild(p);
	authorsDropList.appendChild(div);
	searchArray = keyWordArrayGenerator(text);
	for (author of authors.items){
		str = author.firstName.toLowerCase() + " " + author.lastName.toLowerCase();
		allWordsMatched = true;
		for(searchWord of searchArray){
			if (!allWordsMatched) break;
			allWordsMatched = allWordsMatched && str.includes(searchWord);
		}
		if(allWordsMatched){
			div = document.createElement("div");
			div.classList.add('listItem');
			dataP = document.createElement("p");
			dataP.hidden = true;
			dataP.innerHTML = JSON.stringify(author);
			div.appendChild(dataP);
			p = document.createElement("p");
			p.id="listItem-"+author.id;
			p.innerHTML = author.lastName+", "+author.firstName;
			div.appendChild(p);
			authorsDropList.appendChild(div);
			p.addEventListener("click",appendToAuthorsTable,false);
		}
	}
	showList();
}


function hideList(event){
	if (event.target.id=="authorsDropInput"){
		return;
	}
	document.removeEventListener("click",hideList);
	authorsDropList.style.overflow= "hidden";
	height = authorsDropList.offsetHeight;
	var interval = setInterval(reduceSize,1);
	function reduceSize(){
		if (height < 1){
			document.getElementById('authorsDropInput').value = lookUpAuthorText;
			authorsDropList.hidden = true;
			clearInterval(interval);
			
		} else{
			height = height - 2;
			authorsDropList.style.maxHeight=""+height+"px";
		}
	}
}
function showList(){
	authorsDropList.hidden = false;
	var height;
	var interval = setInterval(increaseSize,1);
	function increaseSize(){
		height = Number(authorsDropList.style.maxHeight.substr(0,(authorsDropList.style.maxHeight.length)-2));
		if(height >= 200){
			clearInterval(interval);
			document.addEventListener("click",hideList);
		} else {
			height = height + 2;
			authorsDropList.style.maxHeight=""+height+"px";
		}
	}
	authorsDropList.style.overflow= "auto";
}


/*
 * addedAuthorsIds holds the ids of authors loaded in the document's authors table.
 * This is how the the page knows whether an author has already been loaded or not, not to load it more than once.
 * If a new author is being loaded, it will be identified with 0.
 */
addedAuthorsIds=[];
function appendToAuthorsTable(event){
	author = JSON.parse(event.target.parentElement.firstChild.innerHTML);
	if (addedAuthorsIds.includes(author.id)) return;
	tBody = documentAuthorsTable.tBodies[0];
	row = tBody.insertRow();
	id = row.insertCell();
	firstName = row.insertCell();
	lastName = row.insertCell();
	options = row.insertCell();
	if (author.id == 0 ){
		okIcon = createOkIcon();
		okIcon.classList.add("okIcon");
		okIcon.addEventListener("click",acceptNewAuthor);
		id.appendChild(okIcon);
		input = document.createElement("input");
		firstName.appendChild(input);
		input = document.createElement("input");
		lastName.appendChild(input);
		/*
		unshift instead of push for optimisation when adding new author.
		See function acceptNewAuthor(event).
		*/
		addedAuthorsIds.unshift(0);
	} else{
		id.innerHTML = author.id;
		firstName.innerHTML = author.firstName;
		lastName.innerHTML = author.lastName;
		addedAuthorsIds.push(author.id);
	}
	options.appendChild(createRemoveIcon());
	options.appendChild(createArrowUp());
	options.appendChild(createArrowDown());
	updateTableOptions();
	validateAuthorsField();
}

/*
 *
 *
 */
function validateAuthorsField(){ 
	let rows = documentAuthorsTable.tBodies[0].children;
	let validRows = false;
	for (row of rows){
		if (row.firstChild.firstChild.tagName=="SPAN") continue;
		validRows = true;
		break;
	}
	fieldManager.authors.valid = validRows;
	allFieldsValidation(validRows);
}

function acceptNewAuthor(event){
	row = event.target.parentElement.parentElement;
	row.firstChild.innerHTML = "new";
	row.firstChild.classList.add("remarked");
	firstName = row.children[1].firstChild.value;
	row.children[1].innerHTML = firstName;
	lastName = row.children[2].firstChild.value;
	row.children[2].innerHTML = lastName;
	addedAuthorsIds.shift();// The momentary id of the new author, 0, has been unshifted, instead of pushed.
							// This saves the programme having to iterate to find where whitin the array was the 0 stored.
	validateAuthorsField();
}

function createArrowUp(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("glyphicon-chevron-up");
	span.classList.add("regularGlyph");
	return span;
}


function createRemoveIcon(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("glyphicon-remove");
	span.classList.add("removeIcon");
	return span;
}

function createOkIcon(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("glyphicon-ok");
	span.classList.add("okIcon");
	return span;
}

function createArrowDown(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("glyphicon-chevron-down");
	span.classList.add("regularGlyph");
	return span;
}

function createRawIcon(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("regularGlyph");
	span.classList.add("enabled");
	return span;
}

function createSortIcon(){
	span = document.createElement("span");
	span.classList.add("glyphicon");
	span.classList.add("glyphicon-sort");
	span.classList.add("regularGlyph");
	span.style.fontSize="12px";
	span.style.margin="0";
	return span;
} 


function updateTableOptions(){
	tBody = documentAuthorsTable.tBodies[0];
	rows = tBody.children;
	for (i = 0; i < rows.length; i++){
		optionsCell = rows[i].lastChild;
		removeIcon = optionsCell.children[0];
		removeIcon.addEventListener("click",removeRow);
		removeIcon.id = "remove-"+i;
		arrowUp = optionsCell.children[1];
		arrowUp.id = "up-"+i;
		arrowDown = optionsCell.children[2];
		arrowDown.id = "down-"+i;
		if (rows.length == 1){
			arrowUp.classList.remove("enabled");
			arrowUp.removeEventListener("click",move);
			arrowDown.classList.remove("enabled");
			arrowDown.removeEventListener("click",move);
		} else{
			if (i > 0){
				arrowUp.classList.add("enabled");
				arrowUp.addEventListener("click",move);
				if(i < rows.length - 1){
					arrowDown.classList.add("enabled");
					arrowDown.addEventListener("click",move);
				} else{
					arrowDown.classList.remove("enabled");
					arrowDown.removeEventListener("click",move);
				}

			} else {
				arrowUp.classList.remove("enabled");
				arrowUp.removeEventListener("click",move);
				arrowDown.classList.add("enabled");
				arrowDown.addEventListener("click",move);
			}
		}
	}
}
function removeRow(event){
	rowNumber= Number(event.target.id.split("-")[1]);
	tBody = documentAuthorsTable.tBodies[0];
	tr = tBody.children[rowNumber];
	idCell = tr.firstChild;
	if (idCell.firstChild.tagName=="SPAN"){ // In case is an entering author row
		addedAuthorsIds.shift() // remove 0 from array
	} else if (idCell.firstChild.innerHTML == "new"){

	} else{
		authorId = Number(idCell.innerHTML);
		for (i=0; i<addedAuthorsIds.length; i++){
			if (addedAuthorsIds[i]==authorId){
				addedAuthorsIds.splice(i,1);
				break;
			}
		}
	}
	opacity = tr.style.opacity || 1;
	
	var interval = setInterval(fade,1);
	function fade(){
		if (opacity < 0){
			clearInterval(interval);
			tBody.deleteRow(rowNumber);
			updateTableOptions();
			validateAuthorsField();
		} else{
			opacity = opacity - 0.01;
			tr.style.opacity=opacity;
		}
	}
	
}

function move(event){
	idChunks = event.target.id.split("-");
	rowNumber = Number(idChunks[1]);
	if(idChunks[0]==="down") {
		rowNumber ++;
	}
	tBody = documentAuthorsTable.tBodies[0];
	row = tBody.children[rowNumber];
	tr = row.cloneNode(true);

	if (tr.firstChild.firstChild.tagName =="SPAN"){
		tr.firstChild.firstChild.addEventListener("click",acceptNewAuthor)
	}
	tBody.deleteRow(rowNumber);
	tBody.insertBefore(tr,tBody.children[rowNumber-1]);
	updateTableOptions();
}

function keyWordArrayGenerator(phrase){
	phrase = phrase.replace(/(\s|,)+/g,".");
	phrase = phrase.replace(/\.+/g,".");
	phrase = phrase.replace(/^\.|\.$/g,"");
	phrase = phrase.toLowerCase();
	phraseBits = phrase.split(".");
	phraseBits.sort(function(a,b){
		return (b.length - a.length)
	});
//Lo que hago ac� es descartar palabras que sean parte de otras palabras. Por ejemplo descarto "para" si existe "parachute"
	for( let i = 0; i < phraseBits.length; i++){
		for (let e = i; e < phraseBits.length; e++){
			if (e === i) {
				continue;
			}
			if (phraseBits[i] === phraseBits[e]){
				phraseBits.splice(e,1);
				e--;
				continue;
			}
			if (phraseBits[i].includes(phraseBits[e])){
				phraseBits.splice(e,1);
				e--;
			}
		}
	}
	return phraseBits;
}
docsHeader = document.getElementById("docsHeader");
columns = docsHeader.getElementsByTagName("tr")[0].children;
for (column of columns){
	if (!column.innerText) continue;
	sort = createSortIcon();
	column.append(sort);
	if(column.innerText.toLowerCase()=="id"){
		sort.addEventListener("click",function(){orderDocsBy("id")});
	} else if (column.innerText.toLowerCase()=="type"){
		sort.addEventListener("click",function(){orderDocsBy("docType")});
	} else if (column.innerText.toLowerCase()=="authors"){
		sort.addEventListener("click",function(){orderDocsBy("authors")});
	} else if (column.innerText.toLowerCase()=="title"){
		sort.addEventListener("click",function(){orderDocsBy("title")});
	}
}
var enableSorting;


function fillDocsTable(){
	if (!refreshDocsTable) return;
	refreshDocsTable = false;
	tBody =	docsTable.tBodies[0];
	tBody.innerHTML = null;
	tHead = document.getElementById("docsHeader");
	sorters = tHead.getElementsByClassName("glyphicon-sort");
	if (documents.items.length < 1){
		enableSorting=false;
		for (sorter of sorters){
			sorter.classList.remove("enabled");
		}
		return;
	}
	let displayableItems=0;
	for(doc of documents.items){
		if (doc.display){
			displayableItems++;
		}
	}
	if (displayableItems < 2){
		enableSorting = false;
		for (sorter of sorters){
			sorter.classList.remove("enabled");
		}
		if (!displayableItems)
			return;
	} else{
		enableSorting = true;
		for (sorter of sorters){
			sorter.classList.add("enabled");
		}
	}
	
	for (var doc of documents.items){
		if (!doc.display)
			continue;
		tBody.appendChild(doc.tr);
	}
}

maxQuotedAuthors = 5; //This is the maximum number of authors quoted per reference;

function mostrarUOcultarReferencia(event){
	clicked = event.target;
	docId = Number(clicked.id.substring(clicked.id.search("-")+1));
	let found = false;
	for(doc of documents.items){
		if (doc.id == docId && !found){
			doc.addedToReferences = !doc.addedToReferences;
			doc.referencia.hidden = !doc.referencia.hidden;
			found = true;
		}
	}
	
	if (clicked.classList.contains('glyphicon-plus')){
		clicked.classList.add('glyphicon-minus');
		clicked.classList.remove('glyphicon-plus');
	} else{
		clicked.classList.remove('glyphicon-minus');
		clicked.classList.add('glyphicon-plus');
	}
}

function getAuthorNameForReference(author){
	authorString = author.lastName + ",";
	for (name of author.firstName.split(" ")){
		authorString +=" "+name.substring(0,1)+"."
	}
	return authorString;
}

function referenceAuthors(doc){
	var allAuthorsString = "";
	authorsLength = doc.authors.length;
	if (authorsLength > maxQuotedAuthors){
		for (i=0; i < (maxQuotedAuthors - 1); i++){
			if (i>0){
				allAuthorsString+=", "
			}
			allAuthorsString+= getAuthorNameForReference(doc.authors[i])
		}
		allAuthorsString+= " et. al."
	} else {
		for (i=0; i < authorsLength; i++){
			if( i > 0){
				if (i == authorsLength-1){
					allAuthorsString +=" & "
				} else{
					allAuthorsString +=", "
				}
			}
			allAuthorsString += getAuthorNameForReference(doc.authors[i]);
		}
	}
	return allAuthorsString;
}

function getBookReference(book){
	//AUTHORS
	var refString = referenceAuthors(book);
	//YEAR
	if (book.year != null){
		refString += " ("+book.year+").";
	}
	//TITLE
	if (book.title != null){
		refString += " <i>"+ book.title;
		//SUB-TITLE
		if (book.subTitle != null){
			refString += " "+book.subTitle;
		}
		refString +="</i>."
	}
	//EDITION
	if (book.edition != null && book.edition != 1){
		refString += " "+book.edition;
		ed = book.edition.toString();
		if (ed.endsWith('13') || ed.endsWith('12') || ed.endsWith('11')){
			refString +="th";
		} else if (ed.endsWith('1')){
			refString += "st";
		} else if (ed.endsWith('2')){
			refString += "nd";
		} else if (ed.endsWith('3')){
			refString += "rd";
		} else {
			refString += "th";
		}
		refString += " ed.";
	}
	//PUBLISHER
	if (book.publisher != null){
		refString += " "+book.publisher;
		if (book.publisherLocation != null){
			refString +=", "+book.publisherLocation;
		}
		refString +=".";
	}
	return refString;
}

function getJournalArticleReference(journalArticle){
	ja = journalArticle;
	//AUTHORS
	var refString = referenceAuthors(ja);
	//YEAR
	if (ja.year != null){
		refString += " ("+ja.year+").";
	}
	//TITLE
	if (ja.title != null){
		refString += " "+ja.title;
		if (ja.subTitle != null){
			refString += " "+ja.subTitle;
		}
		refString += "."
	}
	// JOURNAL NAME
	if (ja.journalName != null){
		refString +=" <i>"+ja.journalName+"</i>";
		// VOLUME
		if (ja.volume != null){
			refString += ", <i>"+ja.volume.volumeNumber+"</i>";
			if (ja.volume.volumeRelease){
				refString+="("+ja.volume.volumeRelease+")";
			}
		}
		refString +=",";
	}
	// PAGES
	if (ja.startPage != null && ja.endPage != null){
	refString += " "+ja.startPage+"-"+ja.endPage+"."
	}
	//DOI
	if (ja.doi != null){
		refString += " DOI: "+ja.doi+".";
	}
	return refString;
}


function fetchDocTypes(){
	let p = new Promise(function(resolve){
		
			let ajax = new XMLHttpRequest();
			ajax.onreadystatechange = function(){
				if (ajax.readyState == 4 && ajax.status == 200){
					docTypes.items = JSON.parse(ajax.response);
					let docTypeSelector = document.getElementById("docTypeSelector");
					for (let docType of docTypes.items){
						option = document.createElement("option")
						textNode = document.createTextNode(docType.description);
						option.appendChild(textNode);
						option.value = docType.id;
						docTypeSelector.appendChild(option);
					}
					docTypeSelector.onchange = function(){
						option = docTypeSelector.value;
						fields = document.getElementById("fields");
						if (option == 0){
							fields.hidden = true;
							document.getElementById("registerButton").disabled = true;
							return;
						}
						fields.hidden = false;
						/*
						fieldManager.*.required can take the following values:
							0: not required
							1: required
							2: optional
						*/
						fieldManager.date.required = 1;
						fieldManager.journalName.required = (option==3)? 1 : 0;
						fieldManager.title.required = 1;
						fieldManager.subTitle.required = 2;
						fieldManager.volNumber.required = (option==3)? 1 : 0;
						fieldManager.volRelease.required = (option==3)? 2 : 0;
						fieldManager.edition.required = (option == 1)? 2 : 0;
						fieldManager.publisher.required = (option == 1)?1:((option == 2)?2:0);
						fieldManager.publisherLocation.required = (option == 1 || option == 2)?2:0;
						fieldManager.startPage.required = (option == 3)? 1 : 0;
						fieldManager.endPage.required = (option == 3)? 1 : 0;
						fieldManager.doi.required = (option == 3)? 2: 0;
						fieldManager.source.required = 2;
						fieldManager.authors.required = 1;

						for (each in fieldManager){
							fieldManager[each].star.hidden = (fieldManager[each].required !=1);
							fieldManager[each].field.hidden = (fieldManager[each].required == 0);
							if (each == "authors"){
								fieldManager.authors.valid |= fieldManager.authors.required !=1;
								continue;
							}
							fieldManager[each].valid = ( fieldManager[each].required !=1);
							fieldManager[each].field.getElementsByTagName("input")[0].value='';
						}
						registerEnabled = false;
						allFieldsValidation(true);
					};
					resolve();
				}
			}
			ajax.open("GET","doc_types",true);
			ajax.send();
		
	});
	return p;
}

function fetchDocuments(){
	let p = new Promise(function(resolve){
		let ajax = new XMLHttpRequest();
		ajax.onreadystatechange = function(){
				if (ajax.readyState == 4 && ajax.status == 200){
					documents.items = JSON.parse(ajax.response);
					documents.items.forEach(function(item){
												item.display = true;
												item.addedToReferences = false;
												item.tr = crearFilaDocumento(item);
											});
					
					enableSorting = (documents.items.length > 1);
					orderDocsBy("authors");//This line orders the docs by author to create the references.
					documents.items.forEach((item)=>{
						item.referencia = crearLineaReferencia(item);
						references.appendChild(item.referencia);
					});
					orderDocsBy("id");
				resolve();
				}
			}
			ajax.open("GET","document_dto",true);
			ajax.send();
		
	});
	return p;
}

function postNewDocument(newDocument){
	newDocument.display = true;
	newDocument.addedToReferences = false;
	newDocument.tr = crearFilaDocumento(newDocument);
	newDocument.referencia = crearLineaReferencia(newDocument);
	documents.items.push(newDocument);
	enableSorting = (documents.items.length > 1);
	orderDocsBy("authors");
	references.innerHTML = null;
	documents.items.forEach((item)=>references.appendChild(item.referencia));
	orderDocsBy("id");
	document.getElementById("docSearch").onkeyup();
}

function crearFilaDocumento(item){
		row = document.createElement("tr");
		row.id = item.id;
		cell = row.insertCell();
		cell.innerHTML = item.id;
		
		cell = row.insertCell();
		cell.innerHTML = item.docType.description;
		
		cell = row.insertCell();
		ul = document.createElement("ul");
		cell.appendChild(ul);
		for (author of item.authors){
			li = document.createElement("li");
			ul.appendChild(li);
			names = author.firstName.split();
			initials = "";
			for (let name of names){
				initials+= " "+name.substring(0,1)+"."
			}
			textNode = document.createTextNode(
					author.lastName+","+initials);
			li.appendChild(textNode);
		}
		
		cell = row.insertCell();
		cell.classList.add("title");
		cell.id = "title-"+item.id;
		cell.innerHTML = item.title;
		cell.onclick = function(){visualiseDocument(this);};
		
		cell = row.insertCell();
		plusOrMinusIcon = createRawIcon();
		plusOrMinusIcon.classList.add('glyphicon-plus');
		plusOrMinusIcon.addEventListener("click",mostrarUOcultarReferencia);
		plusOrMinusIcon.id = "plusOrMinusIcon-"+item.id;//So that it can be easily gotten within the table.
		cell.appendChild(plusOrMinusIcon);
		cell = row.insertCell();
		cell.hidden = true;
		cell.innerHTML = item.approxRequiredLengthForFile;
		return row;
}

function crearLineaReferencia(item){
	linea = document.createElement("p");
	linea.hidden = true;
	linea.id = "referencia-"+item.id;
	if (item.docType.id!=3){
		linea.innerHTML = getBookReference(item);
	} else {
		linea.innerHTML = getJournalArticleReference(item);
	}
	return linea;
}

function fetchAuthors(){
	let p = new Promise(function(resolve){
		let ajax = new XMLHttpRequest();
		ajax.onreadystatechange = function(){
			if (ajax.readyState == 4 && ajax.status == 200){
				authors.fetched = true;
				authors.items = JSON.parse(ajax.response);
				authors.items.forEach(item =>item.display = true);
				resolve();
			}
		}
		ajax.open("GET","author_dto",true);
		ajax.send();
	});
	return p;
}

(function (){
	fetchAuthors().then(
		function(){
			fetchDocuments().then(
				function(){
					fetchDocTypes().then(
						function(){
							clearInterval(loadingAnimation);
							loadingTag.parentNode.removeChild(loadingTag);
							document.getElementById("botonera").hidden = false;
						}
					);
				}
			);
		}
	);
 }
)();

function retrieveAuthorsTest(){
	let p = new Promise(function(resolve){
		
			let ajax = new XMLHttpRequest();
			ajax.onreadystatechange = function(){
				if (ajax.readyState == 4 && ajax.status == 200){
					
					resolve(JSON.parse(ajax.response));
				}
			}
			ajax.open("GET","author_dto",true);
			ajax.send();	
		
	});
	return p;
}

function retrieveDocsTest(){
	let p = new Promise(function(resolve){
		
		let ajax = new XMLHttpRequest();
		ajax.onreadystatechange = function(){
			if (ajax.readyState == 4 && ajax.status == 200){
				
				resolve(JSON.parse(ajax.response));
			}
		}
		ajax.open("GET","document_dto",true);
		ajax.send();	
	
	});
	return p;
}

function retrieveDTTest(){
	let p = new Promise(function(resolve){
		
		let ajax = new XMLHttpRequest();
		ajax.onreadystatechange = function(){
			if (ajax.readyState == 4 && ajax.status == 200){
				
				resolve(JSON.parse(ajax.response));
			}
		}
		ajax.open("GET","doc_types",true);
		ajax.send();	
	
	});
	return p;
}



var refreshAuthorsTable = true;

function fillAuthorsTable(){
	if (!refreshAuthorsTable) return;
	refreshAuthorsTable = false;
	authorsTable.innerHTML = null;
	if (authors.items.length < 1){
		return;
	}
	tHead = authorsTable.createTHead();
	tBody = authorsTable.createTBody();
	headerRow = tHead.insertRow();
	let field;
	let cell;
	for( field in authors.items[0]){
		th = document.createElement("th");
		headerRow.appendChild(th);/*insertCell();*/
		th.innerHTML = field;
		th.onclick = function(){orderAuthorsBy(this)};
	}

	for(var author of authors.items){
		row = tBody.insertRow();
		for (field in author){
			cell = row.insertCell();
			if (field ==="documents"){
				let ul = document.createElement("ul");
				cell.appendChild(ul);
				docArray = [];
				for ( doc in author.documents){
					let li = document.createElement("li");
					let textNode = document.createTextNode(author.documents[doc]+" ("+doc+")");
					li.appendChild(textNode);
					ul.appendChild(li);
				}
			} else {
				cell.innerHTML = author[field];
			}
		}
	}
}

function getAuthors(callBack){
	promise = fetchAuthors();
	promise.then(callBack);
}

mimeTypes = {
		jpg: "image/jpeg",
		jpeg: "image/jpeg",
		pdf: "application/pdf",
		mp4: "video/mp4"
}

lastDocumentVisualised = -1;

function visualiseDocument(target){
	id = target.parentElement.firstChild.innerHTML;
	if (id == lastDocumentVisualised){
		lastDocumentVisualised = -1;
		iframe.src = "";
		return;
	}
	lastDocumentVisualised = id;
	transferLength = target.parentElement.lastChild.innerHTML;
	console.log(id);

	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){
			json = JSON.parse(this.response);
			str = atob(json.data);
			mimeType=mimeTypes[json.name.split(".")[1]];
			strBytes = [];
			for(i of str){
				strBytes.push(i.charCodeAt(0));
			}
			byteArray = new Uint8Array(strBytes);
			file = new File([byteArray],json.name,{type: mimeType})
			fileURL = URL.createObjectURL(file);
			iframe.src = fileURL;
			barContainer.hidden = true;
		} else {
			soFar = (this.response.length * 100) /transferLength;
			if (soFar > 100) {
				soFar=100;
			}
			barContainer.hidden = false;
			downloadBar.style.width = ""+soFar+"%";
			downloadBar.setAttribute("aria-valuemin",0);
			downloadBar.setAttribute("aria-valuemax",100);
			downloadBar.setAttribute("aria-valuenow",soFar);
		}
	}
	ajax.open("GET", "file/"+id,true);
	ajax.send();

}

function orderDocsBy(criteria){
	if (!enableSorting) return;
	ret = (documents.order[criteria])?-1:1;
	documents.order[criteria] = !documents.order[criteria];
	for (orderingCriteria in documents.order){
		if (orderingCriteria !=criteria) documents.order[orderingCriteria] = false;
	}
	
	if (criteria==="id"){
		documents.items.sort(function(a,b){
			return (a.id - b.id)*ret;

		})
	} else if (criteria==="title"){
		
		documents.items.sort(function(a, b){
			var x = a.title.toLowerCase();
			var y = b.title.toLowerCase();
			if (x > y) {return ret;}
			if (x < y) {return -ret;}
			return 0;
		});
	} else if (criteria==="docType"){
		documents.items.sort(function(a, b){
			var x = a.docType.description.toLowerCase();
			var y = b.docType.description.toLowerCase();
			if (x > y) {return ret;}
			if (x < y) {return -ret;}
			return 0;
		});
	} else if (criteria==="authors"){
		documents.order.id = false;
		documents.order.docType = false;
		documents.order.title = false;
		documents.items.sort(function (a,b){
			var aString="";
			var bString="";
			for (authorA of a.authors){
				aString+=authorA.lastName+authorA.firstName+" ";
			}
			for (authorB of b.authors){
				bString+=authorB.lastName+authorB.firstName+" ";
			}
			if (aString > bString) return ret;
			if (aString < bString) return -ret;
			return 0;
		});
	}
	refreshDocsTable = true;
	fillDocsTable();
}

function orderAuthorsBy(criteria){
	criteria = target.innerHTML;
	ret = (documents.order[criteria])?-1:1;
	documents.order[criteria] = !documents.order[criteria];
	if (criteria==="id"){
		authors.items.sort(function(a,b){
			return (a.id - b.id)*ret;
		})
	} else if (criteria==="firstName" || criteria==="lastName"){
		authors.items.sort(function(a, b){
			var x = a[criteria].toLowerCase();
			var y = b[criteria].toLowerCase();
			if (x > y) {return ret;}
			if (x < y) {return -ret;}
			return 0;
		});
	}
	fillAuthorsTable();
}
							</script>
</body>

</html>
