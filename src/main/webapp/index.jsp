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
							.title:hover, th:hover {
								color: blue;
								cursor: pointer;
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

						</style>

						<!-- </style> -->
						<title>Document Manager</title>
					</head>
					<body>
						<div class="container">
							<button id="authors" onclick="getAuthors()">Get Autores</button>
							<button id="documents" onclick="getDocuments()">Get	Documentos</button>
							<input type="text" onkeyup="search(this)">

							</div>
							<div class="container">
								<div class="col-sm-6">
									<table id="table" class="table-striped"></table>
								</div>
								<div class="col-sm-6 source">
									<iframe title="file"></iframe>
								</div>
							</div>


							<script>
							var table = document.getElementById("table");
							var iframe = document.getElementsByTagName("iframe")[0];

							var documents ={
								fetched: false,
								items : [],
								order : { 	id: false,
									docType: false,
									authors: false,
									title: false
								}
							};


							function search(target){
								searchArray = keyWordArrayGenerator(target.value);

								promise = fetchDocuments();
								promise.then(innerSearch);

								function innerSearch(){

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

							function keyWordArrayGenerator(phrase){
								phrase = phrase.replace(/(\s|,)+/g,".");
								phrase = phrase.replace(/\.+/g,".");
								phrase = phrase.replace(/^\.|\.$/g,"");
								phrase = phrase.toLowerCase();
								phraseBits = phrase.split(".");
								phraseBits.sort(function(a,b){
									return (b.length - a.length)
								});
								//Lo que hago ac� es descartar palabras que sean  parte de otras palabras. Por ejemplo descarto "para" si existe "paraca�das"
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
									th = document.createElement("th");
									headerRow.appendChild(th);
									th.innerHTML = field;
									th.onclick = function(){orderBy(this)};
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
											}else {
												cell.innerHTML = doc[field];
											}
										}
									}

								}


								async function fetchDocuments(){
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
												th = document.createElement("th");
												headerRow.appendChild(th);/*insertCell();*/
												th.innerHTML = field;
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
								function visualiseDocument(target){
									id = target.parentElement.firstChild.innerHTML;
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

								function orderBy(target){
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

							</script>
						</body>

					</html>
