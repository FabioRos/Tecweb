<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
	   <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="author" content="Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero"/>
    <meta name="language" content="italian it"/>
    <meta name="rating" content="safe for kids" />
    <meta name="description" content="Il portale di news, articoli, recensioni ed eventi dedicato alla musica"/>
    <meta name="keywords" content="musica, news, news musicali, notizie, album"/>
    <meta name="keywords" content="music, magazine, news"/>
    <meta name="robots" content="all" />
    <link rel="icon" href="../img/fav.ico" type="image/icon" />
    <link rel="stylesheet" type="text/css" media="handheld, screen" href="../css/screen.css"/>
    <link rel="stylesheet" type="text/css" media="print" href="../css/print.css"/>
    <link rel="stylesheet" type="text/css" media="speech" href="../css/aural.css"/>
    <title>Home - Music Break</title>
  </head>
	<body>
    <div id="header">
      <a class="help" href="#nav">salta intestazione</a>
      <div id="title">
        <span id="logo" class="notAural"><img src="../img/logo.png" alt="Logo del sito Music Break"/></span>
        <h1><span xml:lang="eng">Music Break</span></h1>
        <h2>Il portale di notizie dedicato alla musica</h2>
      </div>
      <div id="search">
        <input type="text" id="text_field" value="" name="query" tabindex="1"></input>
        <input type="submit" alt="inserire una ricerca" value="Cerca" tabindex="3"></input>
        <input type="hidden" value="Home.html" name="sitesearch"></input>
      </div>
    </div>
    <div id="nav">
      <a class="help" href="#contents">salta menù</a>
      <ul>
        <li><a href="../home.html"><span xml:lang="eng">Home</span></a></li>
        <li><a href="../news.html"><span xml:lang="eng">News</span></a></li>
        <li><a href="../interviste.html">Interviste</a></li>
        <li><a href="../recensioni.html">Recensioni</a></li>
        <li><a href="../eventi.html">Eventi</a></li>
      </ul> 
    </div>
    <div id="contents">
      <h1>Post</h1>
      <a class="help" href="#sidebar">salta contenuto</a>
      <xsl:for-each select="posts/post[@id=$post]">
        <h1><xsl:value-of select="titolo"/></h1>
        <p>Scritto il <xsl:value-of select="data"/> da <xsl:value-of select="editore/nome"/>&#160;<xsl:value-of select="editore/cognome"/></p>
        <p><xsl:value-of select="testo"/></p>
        <p>Tags: <xsl:for-each select="tags/tag">&#160;<xsl:value-of select="text()"/></xsl:for-each> </p>
      </xsl:for-each>
    </div>
    
    <div id="footer" tabindex="">
      <a class="help" href="#header">salta testo a fine pagina</a>
      <p> 2014 Music Break All Right Reserved. | 
        <a href="info.html"> Chi siamo</a> | 
        <a href="http://it.wikipedia.org/wiki/Copyright">Condizioni d'uso</a> | 
        <a href="contact.html"> Contatti</a> | 
        <a href="rss"> Feed RSS</a>
      </p>
    </div>
  </body>
</html>
	</xsl:template>
</xsl:stylesheet>
