<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="post">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
    		<head>
        		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        		<meta name="author" content="Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero"/>
        		<meta name="language" content="italian it"/>
        		<meta name="rating" content="safe for kids" />
        		<meta name="description" content="Il portale di news, articoli, recensioni ed eventi dedicato alla musica"/>
        		<meta name="keywords" content="musica, news, news musicali, notizie, album"/>
        		<meta name="robots" content="all" />
        		<link rel="icon" href="./img/favicon.ico" type="image/icon" />
        		<link rel="stylesheet" type="text/css" media="handheld, screen" href="./css/screen.css"/>
        		<link rel="stylesheet" type="text/css" media="print" href="./css/print.css"/>
        		<link rel="stylesheet" type="text/css" media="speech" href="./css/aural.css"/>
        		<title>News - Music Break</title>
    		</head>
    		<body>
        		<div id="header">
              		<div id="title">
                		<span id="logo" class="notAural"><img src="./img/tazza-di-caffe.jpg" alt="Logo del sito Music Break"/></span>
                		<h1><span xml:lang="eng">Music Break</span></h1>
                		<h2>Il portale di notizie dedicato alla musica</h2>
              		</div>
        		</div>
        		<div id="nav">
            		<a class="help" href="#contents">salta menù</a>
            		<ul>
                		<li><a href="home.html" tabindex="5"><span xml:lang="eng">Home</span></a></li>
                		<li id="current_nav"><p xml:lang="eng">News</p></li>
                		<li><a href="interviste.html" tabindex="13">Interviste</a></li>
                		<li><a href="recensioni.html" tabindex="21">Recensioni</a></li>
                		<li><a href="eventi.html" tabindex="34">Eventi</a></li>
            		</ul>
            		<div id="search">
                  		<input type="text" id="text_field" value="" name="query" tabindex="1"></input>
                  		<input type="submit" alt="inserire una ricerca" value="Cerca" tabindex="3"></input>
                  		<input type="hidden" value="Home.html" name="sitesearch"></input>
            		</div> 
        		</div>
        		<div id="contents">
            		<h1><span xml:lang="eng">NEWS</span></h1>
            		<a class="help" href="#sidebar">salta contenuto</a>
            		<div class="article">
                		<h2><a href="news.html/Trio%20Pauer%20Fuoco%20a%20Carmignano" tabindex="55">B  Trio Pauer: Fuoco a Carmignano!</a></h2>
                		<span class="author">di Alberto Andeliero 20/01/2014</span>
                		<img src="./img/triopauer.jpg" />
                		<p>
                			In occasione della "fuoriuscita" del nuovo singolo "fuoco a carmignano!", i trio pauer hanno concesso un'intervista per Music Break in esclusiva.
                		</p>
                		<a class="continua" href="news.html/Trio%20Pauer%20Fuoco%20a%20Carmignano">continua →</a>
                		<div class="tag_title">Tag Articolo:</div>
                		<a class="taglink" rel="tag" href="./tag/BTrioPauer/">B  Trio Pauer<span>(9)</span></a>
            		</div>
            		<div class="article">
                		<h2><a href="news.html/Slash%20intervista%20esclusiva" tabindex="85">Slash: «Adesso sono una persona tranquilla e bevo solo acqua». Intervista esclusiva</a></h2>
                		<span class="author">di Alberto Andeliero 20/01/2014</span>
                		<img src="./img/slash.jpg" />
                		<p>In occasione della tournée italiana per il nuovo album da solista Apocalyptic Love, ci siamo fatti raccontare dal chitarrista la sua nuova vita, senza eccessi ma con la stessa voglia di suonare...</p>
                		<a class="continua" href="news.html/Slash%20intervista%20esclusiva">continua →</a>
                		<div class="tag_title">Tag Articolo:</div>
                		<a class="taglink" rel="tag" href="./tag/Slash/">Slash <span>(666)</span></a>
            		</div>
            		<div id="nav_pagine">
                		<a href="#" tabindex="150"></a>
                		<a href="#" tabindex="155"></a>
                		<span>1</span>
                		<a href="#" tabindex="160"></a>
                		<a href="#" tabindex="165"></a>
            		</div>        
        		</div>
 				<div id="footer">
      				<a class="help" href="#header">salta testo a fine pagina</a>
      				<p>copy; 2014 Music Break All Right Reserved. | 
        			<a href="info.html" tabindex="920"> Chi siamo</a> | 
        			<a href="condizioni.html" tabindex="930">Condizioni d'uso</a> | 
        			<a href="contact.html" tabindex="940"> Contatti</a> | 
        			<a href="rss" tabindex="950"> Feed RSS</a>
      				</p>
    			</div>   
    		</body>
		</html>
	</xsl:template>
</xsl:stylesheet>