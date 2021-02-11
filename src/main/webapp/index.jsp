
<html>
<head>
<meta charset="UTF-8">
<title>Document Manager</title>

</head>
<body>
	<button id="authors" onclick="fillTable(this)">Get Autores</button>
	<button id="documents" onclick="fillTable(this)">Get Documentos</button>
	<table id="table">
	</table>
	<p></p>
	<p id="caller"></p>
</body>
<script>
var table = document.getElementById("table");

function fillTable(generator){
	document.getElementById("caller").innerHTML = generator.id;
	ajax = new XMLHttpRequest();
	ajax.onreadystatechange= function(){
		if(this.readyState==4 && this.status == 200){
			
			json = JSON.parse(this.response);
			table.innerHTML = null;
			if (json.length < 1){
				return;
			} 
			header = table.createTHead();
			headerRow = header.insertRow();
			let field;
			let cell;
			for( field in json[0]){
				if (field ==="documents"){
					continue;
				}
				cell = headerRow.insertCell();
				cell.innerHTML = field;
			}
			for(var author of json){
				row = table.insertRow();
				for (field in author){
					if (field ==="documents"){
						continue;
					}
					cell = row.insertCell();
					cell.innerHTML = author[field];
				}
			}
			
			
			document.getElementsByTagName("p")[0].innerHTML = "TOTAL: " + json.length;
		}
	}
	ajax.open("GET", "author_dto",true);
	ajax.send();
}
</script>

</html>