/* BACKEND */

var string="", def, prev, first;
function Wbar(i){
if(i!=prev)
{	first=true;
	prev=i;
	string="";
}
else
	first=false;
if(first)
	def=document.getElementById(i).value;
else
{	if(document.getElementById(i).value!=def)
		string=document.getElementById(i).value;
	}
document.getElementById(i).value=string;
}

// function defbar(i){
// if(document.getElementById(i).value == "")
// {	document.getElementById(i).value= def;
// 	string="";
// }
// }

// function barTitle(){

// }

function checkSonNum(s){
	if(s.childNodes.length<=1)
	{	alert("interno");
		return true;}
	else
	{	alert("ritorno false");
		return false;}
}

function Cdays(x) {
	num=document.getElementById(x).value;

	if( /^[1-9][0-9]{0,2}$/.test(num) )
	{
		if(! (checkSonNum(document.getElementById(x).parentNode)) )
			document.getElementById(x).parentNode.removeChild(node);
	}
	else	
	{		
		if(checkSonNum(document.getElementById(x).parentNode))
		{	node=document.createElement("span");
			var help=document.createTextNode("si richiede un numero positivo <= 999");
			node.appendChild(help);
			document.getElementById(x).parentNode.appendChild(node);}
		document.getElementById(x).value= def;
		string="";
		}
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
