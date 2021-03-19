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
html{
	background-color: #444;
}
body{
	width: 80%;
	height: 100vh;
	margin-left: auto;
	margin-right: auto;
	background-color: #777;
}


.title:hover {
	color: blue;
	cursor: pointer;
}

table {
/* 	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); */
	table-layout: fixed;
	width: 70%;
	border-radius: 6px;
}

tr:nth-child(odd){
	background-color: #EFEFEF;
}
tr:nth-child(even){
	background-color: #E0E0E0;
}
td input{
	width: 125px;
}

.remarked{
	color: blue;
	font-style: italic;
	font-weight: bold;
}
.authorsDropListItem{
	color: black;
	font-style: normal;
	font-weight: normal;
	text-align: left;
}
.listItem{
	text-align: left;
}
.listItem:hover{
	background-color: #ddd;
}
td {
	padding: 10px;
	overflow: hidden;
	text-align: left;
}
td:nth-child(1){
	text-align: right;
}

th {
	padding: 10px;
	text-align: left;
}

/*
#authorsDropInput {
	color: black;
}*/

#authorsDropDiv{
	font-weight: normal;
	text_align: left;
	position:relative;
	width: 100%;
	right: 0;
	padding: 0;
}



#authorsDropList{
	position:absolute;
	width: 100%;
	cursor: pointer;
	background-color: #f1f1f1;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	max-height: 0px;
	overflow: auto;
  	z-index: 1;
  	text-alignment: left;
}
#referencesContainer div{
	margin: 10px 10px;
	padding: 10px, 10px;
}

#references{
	background-color: #EFEFEF;
	border-left: 4px solid #00AA00;
	border-radius:6px;
	height: 20vh;
	overflow: auto;
	position: relative;
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

.removeIcon{
	color: #AA0000;
	cursor: pointer;
}

.okIcon {
	color: #00AA00;
	cursor: pointer;
}
.cont{
position: relative;
margin: auto;
border-radius: 6px;

/* max-width: inherit; */
}


</style>

<title>Document Manager</title>
</head>
<body>
	<div class="cont">
		<button id="authors" onclick="getAuthors(fillAuthorsTable)">Get Authors</button>
		<button id="documents" onclick="getDocuments()">Get	Documents</button>
		<button id="addDocument" onclick="addDocument()">Add Document</button>
	</div>
	<div class="cont" id ="formContainer" onclick="enableHideFormContainer = false"hidden>
		<form id="addForm"action="" >
			<fieldset>
			<legend>New Document</legend>
		<table id="documentAuthorsTable">
			<thead>
				<tr>
					<th colspan="2">Authors</th>
					<th colspan="2">
						<div id="authorsDropDiv" >
							<input id="authorsDropInput" style="width:100%" type="text" value="Look up author ..."
							onfocus="this.value=''"
							onkeyup="searchAuthor(this.value)"
							/>
								<div id="authorsDropList"  >
								</div>
						</div>
					 </th>
				</tr>
				<tr>
					<th>ID</th><th>First name</th><th>Last name</th><th>options</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<span id="dateSpan">Date of publication:<input onkeyup="watchDate(event)"style="width:60px"type="text"/></span>
		
			<input type="submit"/>
			</fieldset>
		</form>
	</div>
	<div id="documentsContainer" class="cont" hidden>
		<input type="text" onkeyup="search(this)"/>
		<div style="padding:0;margin:auto; ">
			<div id="tableScrollableDiv" style="display:inline-block; width:50%; height: 50vh;" >
				<div id="headerDiv" style=" height: 10%">
					<table style="width:100%">
					<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="40%"/>
					<col width="10%"/>
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
				<div id="dataTableDiv" style="width:100%; height: 90%;overflow-y:scroll;border-radius:6px;">
				
			<table id="table" style="width:100%">
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="40%"/>
					<col width="10%"/>
				</colgroup>
				<tbody style="">
				</tbody>
			</table>
				</div>
			</div>
			<div id="previewDiv" style="width:calc(50% - 4px); display: inline-block;position: relative;">
				<iframe title="file" style="height: 50vh;width:100%;border-radius:6px;"></iframe>
				<div class="progress" id="barContainer" style="z-index:10; position:absolute; width: 100%;" hidden>
					<div class="progress-bar" role="progressbar" id="downloadBar" ></div>
				</div>
			</div>
		</div>
		<div id= "referencesContainer" style="position:relative;width:100%; bottom:0;">
		
			<div style="color: #EEEEEE">References</div>
			<div id ="references">
			</div>
		</div>
	</div>


<script>
var table = document.getElementById("table");
var iframe = document.getElementsByTagName("iframe")[0];
var downloadBar = document.getElementById("downloadBar");
var barContainer = document.getElementById("barContainer");
var authorsDropList = document.getElementById("authorsDropList");
var documentAuthorsTable = document.getElementById("documentAuthorsTable");
var references = document.getElementById("references");
var lookUpAuthorText = document.getElementById("authorsDropInput").value;

var documents ={
	fetched: false,
	items : [],
	order : {
		id: true,
		docType: false,
		authors: false,
		title: false
	}
}

authors={
	fetched: false,
	items:[],
	order : {
		id: false,
		firstName: false,
		lastName: false,
	}
}
var noNumberPattern = /[^0-9]/;
var minDate = 1200;
var maxDate = new Date().getFullYear();
function watchDate(event){
	target = event.target;
	date = target.value.substring(0,4);
	date = date.replace(noNumberPattern,"");
	target.value = date;
	
	if (date.length < 4) return;
	
	date = Number(date);
	if (date < minDate){
		target.value = minDate; 
	} else if (date > maxDate){
		target.value =maxDate;
	}
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
	if (!dc.hidden){
		//Setting enableHideDocumentsContainer to false prevents the bubbling of the click
		//that triggered the execution of this function from hiding the documents container.
		enableHideDocumentsContainer = false;
		document.addEventListener("click",hideDocuments);
		promise = fetchDocuments();
		promise.then(fillDocsTable);
	} else {
		document.removeEventListener("click",hideDocuments);
	}
}

function hideDocuments(){
	dc = documentsContainer;
	if(enableHideDocumentsContainer){
		dc.hidden = true;
		document.removeEventListener("click",hideDocuments);
	} else{
		enableHideDocumentsContainer = true;
	}
}

var enableHideFormContainer;

function addDocument(){
	fc= document.getElementById("formContainer");
	fc.hidden = !fc.hidden;
	if(!fc.hidden){
		enableHideFormContainer = false;
		document.addEventListener("click",hideFormContainer);
	} else{
		document.removeEventListener("click",hideFormContainer);
	}
}

function hideFormContainer(){
	fc = document.getElementById("formContainer");
	if(enableHideFormContainer){
		fc.hidden = true;
		document.removeEventListener("click",hideFormContainer);
	} else{
		enableHideFormContainer = true;
	}
}


function search(target){
	searchArray = keyWordArrayGenerator(target.value);
	promise = fetchDocuments();
	promise.then(innerFunction);
	function innerFunction(){
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
	promise = fetchAuthors();
	promise.then(innerFunction);
	function innerFunction(){
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
			clearInterval(interval);
			document.getElementById('authorsDropInput').value = lookUpAuthorText;
			authorsDropList.hidden = true;
			
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
		if(height >= 100){
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
}

/*
 *
 *
 */
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
	idCell = tBody.children[rowNumber].firstChild;
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
	tBody.deleteRow(rowNumber);
	updateTableOptions();
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
	if(column.innerText=="ID"){
		sort.addEventListener("click",function(){orderDocsBy("id")});
	} else if (column.innerText=="Type"){
		sort.addEventListener("click",function(){orderDocsBy("docType")});
	} else if (column.innerText=="Authors"){
		sort.addEventListener("click",function(){orderDocsBy("authors")});
	} else if (column.innerText=="Title"){
		sort.addEventListener("click",function(){orderDocsBy("title")});
	}
}
var enableSorting;

function fillDocsTable(){
	tBody =	table.tBodies[0];
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
	
	let field;
	let cell;
	for (var doc of documents.items){
		if (!doc.display)
			continue;
		row = tBody.insertRow();
		
		cell = row.insertCell();
		cell.innerHTML = doc.id;
		
		cell = row.insertCell();
		cell.innerHTML = doc.docType.type;
		
		cell = row.insertCell();
		ul = document.createElement("ul");
		cell.appendChild(ul);
		for (author of doc.authors){
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
		cell.id = "title-"+(tBody.children.length-1);
		cell.innerHTML = doc.title;
		cell.onclick = function(){visualiseDocument(this);};
		
		cell = row.insertCell();
		plusOrMinusIcon = createRawIcon();
		if (doc.addedToReferences){
			plusOrMinusIcon.classList.remove('glyphicon-plus');
			plusOrMinusIcon.classList.add('glyphicon-minus');
		} else {
			plusOrMinusIcon.classList.add('glyphicon-plus');
			plusOrMinusIcon.classList.remove('glyphicon-minus');
		}
		plusOrMinusIcon.addEventListener("click",addOrRemoveReference);
		cell.appendChild(plusOrMinusIcon);

		cell = row.insertCell();
		cell.hidden = true;
		cell.innerHTML = doc.approxRequiredLengthForFile;
	}
}

maxQuotedAuthors = 5; //This is the maximum number of authors quoted per reference;

function addOrRemoveReference(event){
	clicked = event.target;
	cell = clicked.parentElement;
	row = cell.parentElement;
	id = row.firstChild.innerHTML;
	let found = false;
	addedReferences = [];
	for(doc of documents.items){
		if (doc.id == id && !found){
			doc.addedToReferences = !doc.addedToReferences;
			found = true;
		}
		if (doc.addedToReferences) addedReferences.push(doc);
	}
	if (clicked.classList.contains('glyphicon-plus')){
		clicked.classList.add('glyphicon-minus');
		clicked.classList.remove('glyphicon-plus');
	} else{
		clicked.classList.remove('glyphicon-minus');
		clicked.classList.add('glyphicon-plus');
	}
	addedReferences.sort(function (a,b){
		var aString="";
		var bString="";
		for (authorA of a.authors){
			aString+=authorA.lastName+authorA.firstName;
		}
		for (authorB of b.authors){
			bString+=authorB.lastName+authorB.firstName;
		}
		if (aString > bString) return 1;
		if (aString < bString) return -1;
		return 0;
	});
	references.innerHTML = null;
	for (ref of addedReferences){
		p = document.createElement("p");
		if (ref.docType.id!=3){
			p.innerHTML = getBookReference(ref);
		} else {
			p.innerHTML = getJournalArticleReference(ref);
		}
		references.appendChild(p);
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



function fetchDocuments(){
	let p = new Promise(function(resolve){
		if (documents.fetched){
			resolve();
		}
		else{
			let ajax = new XMLHttpRequest();
			ajax.onreadystatechange = function(){
				if (ajax.readyState == 4 && ajax.status == 200){
					documents.fetched = true;
					documents.items = JSON.parse(ajax.response);
					documents.items.forEach(function(item){
												item.display = true;
												item.addedToReferences = false;
											});
					resolve();
				}
			}
			ajax.open("GET","document_dto",true);
			ajax.send();
		}
	});
	return p;
}

function fetchAuthors(){
	let p = new Promise(function(resolve){
		if (authors.fetched){
			resolve();
		}
		else{
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
		}
	});
	return p;
}



function fillAuthorsTable(){
	table.innerHTML = null;
	if (authors.items.length < 1){
		return;
	}
	tHead = table.createTHead();
	tBody = table.createTBody();
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
			var x = a.docType.type.toLowerCase();
			var y = b.docType.type.toLowerCase();
			if (x > y) {return ret;}
			if (x < y) {return -ret;}
			return 0;
		});
	} else if (criteria==="authors"){
		documents.items.sort(function(a, b){
			auA = a.authors[0];
			nameA =(auA.lastName +auA.firstName).toLowerCase();
			auB = b.authors[0];
			nameB =(auB.lastName +auB.firstName).toLowerCase();
			if (nameA > nameB) {return ret;}
			if (nameA < nameB) {return -ret;}
			return 0;
		});
	}
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
