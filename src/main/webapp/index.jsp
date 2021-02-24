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
.title:hover, #table th:hover {
	color: blue;
	cursor: pointer;
}

.remarked{
	color: blue;
	font-style: italic;
	font-weight: bold;
	text-align: left;
}
.authorsListItem{
	color: black;
	font-style: normal;
	font-weight: normal;
	text-align: left;
}
.authorsListItem:hover, .remarked:hover{
	background-color: #ddd;
}
td {
	padding: 10px;
}

td:nth-child(1) {
	text-align: right;
}

th {
	padding: 10px;
	text-align: center;
}

iframe {
	width: 100%;
	height:600px;
}
/*
#dropInput {
	color: black;
}*/

#authorsDropdown{
	font-weight: normal;
	text_align: left;
	position:relative;
	width: 200px;
	right: 0;
}




#authorsList{
	position:absolute;
	width: 100%;
	cursor: pointer;
	background-color: #f1f1f1;
	box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	max-height:100px;
	overflow: auto;
  	z-index: 1;
  	text-alignment: left;
}



</style>

<title>Document Manager</title>
</head>
<body>
	<div class="container">
		<button id="authors" onclick="getAuthors(fillAuthorsTable)">Get Authors</button>
		<button id="documents" onclick="getDocuments()">Get	Documents</button>
		<button id="addDocument"
			onclick="addDocument()">Add Document</button> 
		<input type="text" onkeyup="search(this)">
	</div>
	<div class="container" id ="formContainer" hidden>
		<form id="addForm"action="" >
			<fieldset>
			<legend>New Document</legend>
		<table id="documentAuthorsTable" class="table-striped">
			<thead>
				<tr>
					<th>Authors</th>
					<th>
						<div id="authorsDropdown">
							<input type="text" value="Look up author ..." onfocus="this.value=''" id="dropInput" onkeyup="searchAuthor(this.value)"/>
								<div id="authorsList" onclick="emptyList(this)">
								</div>
						</div>
					 </th>
				</tr>
				<tr>
					<th>id</th><th>firstName</th><th>lastName</th>
				</tr>		
			</thead>
			<tbody>
			</tbody>
		</table>
			<input type="submit"/>
			</fieldset>
		</form>
	</div>
	<div class="container">
		<div class="col-sm-6">
			<table id="table" class="table-striped"></table>
		</div>
		<div class="col-sm-6 source">
			<iframe title="file"></iframe>
			<div class="progress" id="barContainer" hidden>
				<div class="progress-bar" role="progressbar" id="downloadBar" ></div>
			</div>
		</div>
	</div>
						

<script>

var table = document.getElementById("table");
var iframe = document.getElementsByTagName("iframe")[0];
var downloadBar = document.getElementById("downloadBar");
var barContainer = document.getElementById("barContainer");
var authorsList = document.getElementById("authorsList");
var documentAuthorsTable = document.getElementById("documentAuthorsTable");
var lookUpAuthorText = document.getElementById("dropInput").value;

var documents ={
	fetched: false,
	items : [],
	order : {
		id: false,
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

function addDocument(){
	document.getElementById('formContainer').hidden = false;
	document.getElementById('addDocument').disabled = true;
	addedAuthorsIds=[];
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

function searchAuthor(text){
	authorsList.innerHTML = null;
	p = document.createElement("p");
	p.classList.add("remarked");
	p.innerHTML= "new author";
	authorsList.appendChild(p);
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
				div.classList.add('authorsListItem');
				dataP = document.createElement("p");
				dataP.hidden = true;
				dataP.innerHTML = JSON.stringify(author);
				div.appendChild(dataP);
				p = document.createElement("p");
				p.innerHTML = author.lastName+", "+author.firstName;
				div.appendChild(p);
				authorsList.appendChild(div);
				p.onclick= function(){newAuthor(this)};
			}
		}
		
	}
}

function emptyList(target){
	target.innerHTML=null;
	document.getElementById('dropInput').value = lookUpAuthorText;
}

addedAuthorsIds=[];
function newAuthor(target){
	author = JSON.parse(target.parentElement.firstChild.innerHTML);
	if (addedAuthorsIds.includes(author.id)) return;
	tBody = documentAuthorsTable.tBodies[0];
	row = tBody.insertRow();
	id = row.insertCell();
	id.innerHTML = author.id;
	firstName = row.insertCell();
	firstName.innerHTML = author.firstName;
	lastName = row.insertCell();
	lastName.innerHTML = author.lastName;
	addedAuthorsIds.push(author.id);
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
//Lo que hago acá es descartar palabras que sean parte de otras palabras. Por ejemplo descarto "para" si existe "parachute"
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


function fillDocsTable(){
	table.innerHTML = null;
	if (documents.items.length < 1){
		return;
	}
	toLoad =[];
	for(doc of documents.items){
		if (doc.display){
			toLoad.push(doc);
		}
	}
	if (toLoad.length < 1){
		return;
	}
	
	
	tHead = table.createTHead();
	tBody = table.createTBody();
	headerRow = tHead.insertRow();
	let field;
	let cell;
	for( field in toLoad[0]){
		if (field === "display") continue;
		if (field === "approxRequiredLengthForFile") continue;
		th = document.createElement("th");
		headerRow.appendChild(th);
		th.innerHTML = field;
		th.onclick = function(){orderDocsBy(this)};
	}

	for(var doc of toLoad){
		row = tBody.insertRow();
		for (field in doc){
			if (field === "display") continue;
			cell = row.insertCell();
			cell.style.whiteSpace="nowrap";
	
			if (field ==="docType"){
				cell.innerHTML = doc.docType.type;
			}
			else if (field ==="authors"){
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

			} else if (field === "title"){
				cell.classList.add("title");
				cell.innerHTML = doc.title;
				cell.onclick = function(){visualiseDocument(this);};
			} else if (field ==="approxRequiredLengthForFile"){
				cell.style.visibility = "hidden";
				cell.innerHTML = doc.approxRequiredLengthForFile;
			}else {
				cell.innerHTML = doc[field];
			}
		}
	}
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
					documents.items.forEach(item =>item.display = true);
					resolve();
				}
			}
			ajax.open("GET","document_dto",true);
			ajax.send();
		}
	});
	return p;
}

function getDocuments(){
	promise = fetchDocuments();
	promise.then(fillDocsTable);
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
function visualiseDocument(target){
	id = target.parentElement.firstChild.innerHTML;
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

function orderDocsBy(target){
	criteria = target.innerHTML;
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

function orderAuthorsBy(target){
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
