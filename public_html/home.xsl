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
    <link rel="icon" href="./img/fav.ico" type="image/icon" />
    <link rel="stylesheet" type="text/css" media="handheld, screen" href="./css/screen.css"/>
    <link rel="stylesheet" type="text/css" media="print" href="./css/print.css"/>
    <link rel="stylesheet" type="text/css" media="speech" href="./css/aural.css"/>
    <!--type="text/javascript" href="./javascript/screen.js"/>-->
    <script >
    function searchbar() {
      document.getElementById("text_field").value="";
    }
    function defsearch() {
      document.getElementById("text_field").value="cerca...";
    }
  </script>
    <title>Home - Music Break</title>
  </head>
  <body>
    <div id="header">
      <a class="help" href="#nav">salta intestazione</a>
      <div id="title">
        <span id="logo" class="notAural"><img src="./img/logo.png" alt="Logo del sito Music Break"/></span>
        <h1><span xml:lang="eng">Music Break</span></h1>
        <h2>Il portale di notizie dedicato alla musica</h2>
      </div>
      <div id="search">
        <input type="text" id="text_field" onclick="searchbar();" onblur="defsearch();" value="cerca..." name="query" tabindex=""></input>
        <input type="submit" alt="inserire una ricerca" value="Cerca" tabindex=""></input>
        <input type="hidden" value="Home.html" name="sitesearch"></input>
      </div>
    </div>
    <div id="nav">
      <a class="help" href="#contents">salta menù</a>
      <ul>
        <li id="current_nav"><p xml:lang="eng">Home</p></li>
        <li><a href="cgi-bin/show.cgi?type=n"><span xml:lang="eng">News</span></a></li>
        <li><a href="cgi-bin/show.cgi?type=i">Interviste</a></li>
        <li><a href="cgi-bin/show.cgi?type=r">Recensioni</a></li>
        <li><a href="cgi-bin/show.cgi?type=e">Eventi</a></li>
      </ul> 
    </div>
    <div id="contents_home">
    	<h1><span xml:lang="eng">HOME</span></h1>
      	<a class="help" href="#sidebar">salta contenuto</a>
    	<xsl:for-each select="home/post">
    		<div class="article">
    			<h2><xsl:element name="a">
    				<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    				<xsl:value-of select="titolo"/>
    			</xsl:element></h2>
    			<span class="author">di <xsl:value-of select="data"/> da <xsl:value-of select="editore/nome"/>&#160;<xsl:value-of select="editore/cognome"/></span>
    			<xsl:element name="img">
    				<xsl:attribute name="src"><xsl:copy-of select="foto/src/node()" /></xsl:attribute>
    				<xsl:attribute name="alt"><xsl:copy-of select="foto/alt/node()" /></xsl:attribute>
    			</xsl:element>
    			<p><xsl:value-of select="descr" /></p>
    			<xsl:element name="a">
    				<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    				continua →
    			</xsl:element>
    			<div class="tag_title">Tag Articolo:</div>
    			<xsl:for-each select="tag">&#160;
    				<xsl:element name="a">
    					<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    					<xsl:value-of select="name"/>
    				</xsl:element>
    			</xsl:for-each>
    		</div>
    	</xsl:for-each>
    </div>
    <div id="sidebar">
      <a class="help" href="#footer">salta sidebar</a>
      <h1><span xml:lang="eng">TOP News</span></h1>
        <ol>
          <xsl:for-each select="/home/sidebar/topnews/news">
          	<li>
          		<xsl:element name="a">
    					<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    					<xsl:value-of select="title"/>
    			</xsl:element>
          	</li>
          </xsl:for-each>
        </ol>
      <h1><span xml:lang="eng">TOP</span> Interviste</h1>
      <ol>
        <xsl:for-each select="/home/sidebar/topinterv/interv">
          	<li>
          		<xsl:element name="a">
    					<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    					<xsl:value-of select="title"/>
    			</xsl:element>
          	</li>
          </xsl:for-each>
      </ol>
      <h1><span xml:lang="eng">TOP</span> Recensioni</h1>
      <ol>
        <xsl:for-each select="/home/sidebar/toprec/rec">
          	<li>
          		<xsl:element name="a">
    					<xsl:attribute name="href"><xsl:copy-of select="link/node()" /></xsl:attribute>
    					<xsl:value-of select="title"/>
    			</xsl:element>
          	</li>
          </xsl:for-each>
      </ol>
    </div>
    <div id="footer" tabindex="">
      <a class="help" href="#header">salta testo a fine pagina</a>
      <p>copy; 2014 Music Break All Right Reserved. | 
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