/* BACKEND */
//def contiene il valore di default dato come help
var def=new Array(),check=new Array();

//FUNZIONI ONLOAD

function setArray(){//def è un array associativo del tipo def[id]="valore di default del placeholder"
var a=document.getElementById("formfield");
a=removeBlankspace(a);
a=a.getElementsByTagName("div");
for(var i=0;i<a.length;++i)
{
	check[i]=a[i].firstChild.id;//non è inutile come può sembrare,mi serve nella funzione checkSubmit
	def[a[i].firstChild.id]=a[i].firstChild.value;
}
}

function removeBlankspace(n)
{
  for (var i=0; i< n.childNodes.length; i++)
  {
    var child = n.childNodes[i];
    if(child.nodeType == 3 && !/\S/.test(child.nodeValue))
    {
      n.removeChild(child);
      i--;
    }
    if(child.nodeType == 1)
    {
      removeBlankspace(child);
    }
  }
  return n;
}

//FUNZIONI ONCLICK

function Wbar(x){
if(checkSonNum(document.getElementById(x).parentNode))
	insertHelp(x);
if(document.getElementById(x).value == def[x])
	document.getElementById(x).value= "";
}

function checkSonNum(u){
	if(u.childNodes.length<=1)
		return true;
	else
		return false;
}

function insertHelp(x){
	node=document.createElement("span");//node globale,lo creo qui per la prima volta
	node.className="jsHelp";
	node.appendChild(document.createTextNode(def[x]));
	document.getElementById(x).parentNode.appendChild(node);
}

//FUNZIONI ONBLUR
function Bbar(x){
	document.getElementById(x).parentNode.removeChild(node);
}

//FUNZIONI ONSUBMIT
function createErr(txt){
	node=document.createElement("span");
	node.className="jsErr";
	node.appendChild(txt);
	return node;
}

function checkSubmit(){
for(var i=0;i< check.length;++i)
	{
		var y="C"+check[i];
		var txt=window[y]();
		var parent=document.getElementById(check[i]).parentNode;
		if(checkSonNum(parent) && txt)
			parent.appendChild(createErr(txt));
	}
}

function Ctitolo(){
	var string=document.getElementById("titolo").value;
	if(string.length<2 || string.length>75)
		return document.createTextNode("inserire un minimo di 2 e un massimo di 75 caratteri");
	else
		return false;
}

function Calt(){
	var t="alt";
	var string=document.getElementById(t).value;
	string=countWords(string);
	if(string<2 || string>50)
		return document.createTextNode("inserire un minimo di 2 e un massimo di 50 parole");
	else
		return false;
}

function countWords(u){
var num = 0;
u=u.replace(/\s/g,' ');
u=u.split(' ');
for(var j=0;j<u.length;++j) {
	if (u[j].length > 0) 
		++num;
}
return num;
}

function Cexcerpt(){
	var t="excerpt";
	var string=document.getElementById(t).value;
	string=countWords(string);
	if(string<5 || string>50)
		return document.createTextNode("inserire un minimo di 5 e un massimo di 50 parole");
	else
		return false;
}

function Cdescrizione(){
	var t="descrizione";
	var string=document.getElementById(t).value;
	string=countWords(string);
	if(string<50 || string>500)
		return document.createTextNode("inserire un minimo di 50 e un massimo di 500 parole");
	else
		return false;
}

function Ctags(){
	var t="tags";
	var string=document.getElementById(t).value;
	string=countWords(string);
	if(string==0)//non serve controllare la virgola perchè nel caso avessi tag composti(tipo "electronic music" non potrei distinguerli con RegExp)
		return document.createTextNode("inserire un minimo di 1 tag,se più di uno allora separarli usando la virgola");
	else
		return false;
}

//SUBMIT DI INTERVISTE
function Cintervistato(){
	var t="intervistato";
	var string=document.getElementById(t).value;
	string=countWords(string);
	if(string<1 || string>5)
		return document.createTextNode("inserire un minimo di 1 e un massimo di 5 parole");
	else
		return false;
}

//SUBMIT DI EVENTI
function CnumGiorni(){
	var t="numGiorni";
	var num=document.getElementById(t).value;
	if( /^[1-9][0-9]{0,2}$/.test(num) )
		return false;
	else
		return document.createTextNode("inserire un numero positivo <= 999");
}

function CoraFine(){
	return CoraInizio("oraFine");
}

function CoraInizio(t){
	if(typeof t === "undefined")
		t="oraInizio";
	var h=document.getElementById(t).value;
	if(/^(10|11|12|[1-9]):[0-5][0-9]$/.test(h))
		return false;
	else
		return document.createTextNode("inserire un ora compresa tra 1:00 e 12:59");
}

function Cprezzo(){
	var t="prezzo";
	var p=document.getElementById(t).value;
	if(/^([1-9]{0,2}[0-9]).[0-9][0-9]$/.test(p))
		return false;
	else
		return document.createTextNode("inserire un prezzo nel formato $$$.$$ oppure $$.$$ oppure $.$$");
}

function Ctelefono(){
	var t="telefono";
	var n=document.getElementById(t).value;
	if(/^[0-9]{10,10}$/.test(n))
		return false;
	else
		return document.createTextNode("inserire un numero telefonico composto da 10 cifre");
}

function Cmail(){
	var t="mail";
	var m=document.getElementById(t).value;
	if(/^([\w\-\+\.]+)@([\w\-\+\.]+).([\w\-\+\.]+)$/.test(m))
		return false;
	else
		return document.createTextNode("inserire un indirizzo mail valido");
}

function Cluogo(){
	var t="luogo";
	var string=document.getElementById(t).value;
	if(string.length<1 || string.length>58)
		return document.createTextNode("inserire un nome di città con al massimo 58 caratteri");
	else
		return false;
}

// function Cdate(y) {
// 	dat=document.getElementById(y).value;
// 	if( /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/.test(dat))
// 		alert("2");
// 	else
// 	{	document.getElementById(x).value= def;
// 			string="";
// 		}
// }
