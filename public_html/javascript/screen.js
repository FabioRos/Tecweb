/* SEARCHBAR */

function searchbar(){
 document.getElementById("text_field").value="";
}
 function defsearch(){
 document.getElementById("text_field").value="Cerca...";
}

/* GALLERY */

var index=1,last,last0;
var li= document.getElementsByClassName("slide");// .length inizia a contare da 1

/*apertura pagina tramite link*/
// function popUp(winURL){
//     window.open(winURL,"popup","width=320,height=480");
// }
function displayH(){
    document.getElementById("hiddenLink").setAttribute("class","active");
}

function next() {
    document.getElementById("img"+index).setAttribute("class", "hidden");
    document.getElementById("t"+index).setAttribute("class","");
    if( index == li.length)
        index=1;
    else
        index++;
    last=document.getElementById("img"+index);
    last0=document.getElementById("t"+index);
    last.setAttribute("class", "active");
    last0.setAttribute("class","activenav");
    return true;
}

function previous() {
 document.getElementById("img"+index).setAttribute("class", "hidden");
 document.getElementById("t"+index).setAttribute("class","");
    if(index == 1)
        index= li.length;
    else
        index--;
   last=document.getElementById("img"+index);
   last0=document.getElementById("t"+index);
   last.setAttribute("class", "active");
   last0.setAttribute("class","activenav");
    return true;
}
function change(i){
    document.getElementById("img"+index).setAttribute("class","hidden");
    document.getElementById("t"+index).setAttribute("class","");
    index= i;
    last=document.getElementById("img"+index);
    last0=document.getElementById("t"+index);
    last.setAttribute("class","active");
    last0.setAttribute("class","activenav");
    return true;
}