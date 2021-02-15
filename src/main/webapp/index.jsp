<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table {
	border-collapse: collapse;
	margin: 25px 0;
	font-size: 0.9em;
	font-family: sans-serif;
	min-width: 400px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

thead tr {
	background-color: #009879;
	color: #ffffff;
	text-align: left;
}

th, td {
	padding: 12px 15px;
}

tbody tr {
	border-bottom: 1px solid #dddddd;
}

tbody tr:nth-of-type(even) {
	background-color: #f3f3f3;
}

tbody tr:last-of-type {
	border-bottom: 2px solid #009879;
}

tbody tr.active-row {
	font-weight: bold;
	color: #009879;
}
</style>
<title>Document Manager</title>
</head>
<body>
	<button id="authors" onclick="getAuthors()">Get Autores</button>
	<button id="documents" onclick="getDocuments()">Get Documentos</button>
	<table id="table">
	</table>
	<p></p>
	<input id="opener" type="file" style="display: none">
	<iframe height="200" width="300" title="file"></iframe>


	<script>
var table = document.getElementById("table");
iframe = document.getElementsByTagName("iframe")[0];



function getDocuments(){
	table.innerHTML = null;
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){

			json = JSON.parse(this.response);
			if (json.length < 1){
				return;
			}
			tHead = table.createTHead();
			tBody = table.createTBody();
			headerRow = tHead.insertRow();
			let field;
			let cell;
			for( field in json[0]){

				cell = headerRow.insertCell();
				cell.innerHTML = field;
			}
			
			for(var doc of json){
				row = tBody.insertRow();
				for (field in doc){
					cell = row.insertCell();
					cell.style.whiteSpace="nowrap";
					
					if (field ==="docType"){
						cell.innerHTML = doc.docType.type + " ("+doc.docType.id+")";
					} 
					else if (field ==="authors"){
						ol = document.createElement("ol");
						cell.appendChild(ol);
						for (author of doc.authors){
							li = document.createElement("li");
							ol.appendChild(li);
							names = author.firstName.split();
							initials = "";
							for (let name of names){
								initials+= " "+name.substring(0,1)+"."
							}
							
							textNode = document.createTextNode(
									author.lastName+","+initials+" ("+author.id+")");
							li.appendChild(textNode);
						}
						
					} else if (field === "title"){
						p = document.createElement("p");
						p.innerHTML = doc.title;
						cell.appendChild(p);
						p.onclick = function(){loadDocument(this);};
					}else {
					cell.innerHTML = doc[field];
					}
				}
			}


		}
	}
	ajax.open("GET", "document_dto",true);
	ajax.send();
}
function getAuthors(){
	table.innerHTML = null;
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){

			json = JSON.parse(this.response);
			if (json.length < 1){
				return;
			}
			tHead = table.createTHead();
			tBody = table.createTBody();
			headerRow = tHead.insertRow();
			let field;
			let cell;
			for( field in json[0]){

				cell = headerRow.insertCell();
				cell.innerHTML = field;
			}
			
			for(var author of json){
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
	}
	ajax.open("GET", "author_dto",true);
	ajax.send();
}
function loadDocument(target){
	id = target.parentElement.parentElement.firstChild.innerHTML;
	console.log(id);
		
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){
			json = JSON.parse(this.response);
			str = atob(json.data);
			strBytes = [];
			for(i of str){
				strBytes.push(i.charCodeAt(0));
			}
			byteArray = new Uint8Array(strBytes);
			file = new File([byteArray],json.name,{type:"image/jpeg"})
			fileURL = URL.createObjectURL(file);
			iframe.src = fileURL;
		}
	}
	ajax.open("GET", "file/"+id,true);
	ajax.send();

}

</script>
</body>

</html>
