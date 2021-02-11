
<html>
<head>
<meta charset="UTF-8">
<title>Document Manager</title>

</head>
<body>
	<button id="authors" onclick="getAuthors()">Get Autores</button>
	<button id="documents" onclick="getDocuments()">Get Documentos</button>
	<table id="table">
	</table>
	<p></p>
</body>
<script>
var table = document.getElementById("table");


function getDocuments(){
	table.innerHTML = null;
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){

			json = JSON.parse(this.response);
			if (json.length < 1){
				return;
			}
			header = table.createTHead();
			headerRow = header.insertRow();
			let field;
			let cell;
			for( field in json[0]){

				cell = headerRow.insertCell();
				cell.innerHTML = field;
			}
			
			for(var doc of json){
				row = table.insertRow();
				for (field in doc){
					cell = row.insertCell();
					
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
						
					} else if(field === "source"){
						source = doc.source.replace(/\\/g,"/");
						
						a = document.createElement("a");
						cell.appendChild(a);
						a.href = source;
						a.innerHTML = source;
						
					} else {
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
			header = table.createTHead();
			headerRow = header.insertRow();
			let field;
			let cell;
			for( field in json[0]){

				cell = headerRow.insertCell();
				cell.innerHTML = field;
			}
			
			for(var author of json){
				row = table.insertRow();
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

</script>

</html>
