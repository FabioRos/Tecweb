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
        		<meta name="robots" content="all" />
        		<link rel="icon" href="../img/favicon.ico" type="image/icon" />
        		<link rel="stylesheet" type="text/css" media="handheld, screen" href="../css/screen.css"/>
        		<link rel="stylesheet" type="text/css" media="print" href="../css/print.css"/>
        		<link rel="stylesheet" type="text/css" media="speech" href="../css/aural.css"/>
                <title>
                    <xsl:choose>
                        <xsl:when test="$type = string(n)">
                            News - Music Break
                        </xsl:when>
                        <xsl:when test="$type = string(i)">
                            Interviste - Music Break
                        </xsl:when>
                        <xsl:when test="$type = string(r)">
                            Recensioni - Music Break
                        </xsl:when>
                        <xsl:when test="$type = string(e)">
                            Eventi - Music Break
                        </xsl:when>
                    </xsl:choose>
                </title>
        		
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
                    <xsl:choose>
                        <xsl:when test="string($type) = string(n)">
                            <ul>
                                <li><a href="home.xml"><span xml:lang="eng">Home</span></a></li>
                                <li id="current_nav"><a href="show.cgi?type=n"><p xml:lang="eng">News</p></a></li>
                                <li><a href="show.cgi?type=i">Interviste</a></li>
                                <li><a href="show.cgi?type=r">Recensioni</a></li>
                                <li><a href="show.cgi?type=e">Eventi</a></li>
                            </ul>
                        </xsl:when>
                        <xsl:when test="string($type) = string(i)">
                            <ul>
                                <li><a href="home.xml"><span xml:lang="eng">Home</span></a></li>
                                <li><a href="show.cgi?type=n"><p xml:lang="eng">News</p></a></li>
                                <li id="current_nav"><a href="show.cgi?type=i">Interviste</a></li>
                                <li><a href="show.cgi?type=r">Recensioni</a></li>
                                <li><a href="show.cgi?type=e">Eventi</a></li>
                            </ul>
                        </xsl:when>
                        <xsl:when test="string($type) = string(r)">
                            <ul>
                                <li><a href="home.xml"><span xml:lang="eng">Home</span></a></li>
                                <li><a href="show.cgi?type=n"><p xml:lang="eng">News</p></a></li>
                                <li><a href="show.cgi?type=i">Interviste</a></li>
                                <li id="current_nav"><a href="show.cgi?type=r">Recensioni</a></li>
                                <li><a href="show.cgi?type=e">Eventi</a></li>
                            </ul>
                        </xsl:when>
                        <xsl:when test="string($type) = string(e)">
                            <ul>
                                <li><a href="home.xml"><span xml:lang="eng">Home</span></a></li>
                                <li><a href="show.cgi?type=n"><p xml:lang="eng">News</p></a></li>
                                <li><a href="show.cgi?type=i">Interviste</a></li>
                                <li><a href="show.cgi?type=r">Recensioni</a></li>
                                <li id="current_nav"><a href="show.cgi?type=e">Eventi</a></li>
                            </ul>
                        </xsl:when>
                    </xsl:choose>
            		
            		<div id="search">
                  		<input type="text" id="text_field" value="" name="query" tabindex="1"></input>
                  		<input type="submit" alt="inserire una ricerca" value="Cerca" tabindex="3"></input>
                  		<input type="hidden" value="Home.html" name="sitesearch"></input>
            		</div> 
        		</div>
        		<div id="contents">
                    <h1>
                    <xsl:choose>
                        <xsl:when test="string($type) = string(n)">
                            <span xml:lang="eng">NEWS</span>
                        </xsl:when>
                        <xsl:when test="string($type) = string(i)">
                            INTERVISTE
                        </xsl:when>
                        <xsl:when test="string($type) = string(r)">
                            RECENSIONI
                        </xsl:when>
                        <xsl:when test="string($type) = string(e)">
                            EVENTI
                        </xsl:when>
                    </xsl:choose>
                    </h1>
                    <a class="help" href="#footer">salta contenuto</a>
                    <xsl:for-each select="posts/post">
            		  <div class="article">
                        <h2><xsl:element name="a">
                            <xsl:attribute name="href">posts.cgi?post=<xsl:copy-of select="string(@id)" /></xsl:attribute>
                            <xsl:value-of select="titolo"/>
                        </xsl:element></h2>
                		<span class="author">
                            di <xsl:value-of select="editore/nome"/>&#160;
                            <xsl:value-of select="editore/cognome"/>&#160;
                            <xsl:value-of select="data"/>
                        </span>
                		<xsl:element name="img">
                            <xsl:attribute name='src'><xsl:copy-of select="foto/src/node()" /></xsl:attribute>
                            <xsl:attribute name='alt'><xsl:copy-of select="foto/alt/node()" /></xsl:attribute>
                        </xsl:element>
                		<p>
                			<xsl:value-of select="excerpt"/>
                		</p>
                        <xsl:element name="a">
                            <xsl:attribute name="class">continua</xsl:attribute>
                            <xsl:attribute name="href">posts.cgi?post=<xsl:copy-of select="string(@id)" /></xsl:attribute>
                            continua →
                        </xsl:element>
                		<div class="tag_title">Tag Articolo:</div>
                        <xsl:for-each select="tag">&#160;
                            <xsl:element name ="a">
                                <xsl:attribute name="class">taglink</xsl:attribute>
                                <xsl:attribute name="tag">tag</xsl:attribute>
                                <xsl:attribute name="href">searchtags.cgi?idtag=<xsl:value-of select="string(@id)"/></xsl:attribute>
                                <xsl:value-of select="node()"/>
                            </xsl:element>
                        </xsl:for-each>
            		  </div>
                    </xsl:for-each>
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
        			<a href="info.html"> Chi siamo</a> | 
        			<a href="condizioni.html">Condizioni d'uso</a> | 
        			<a href="contact.html"> Contatti</a> | 
        			<a href="rss"> Feed RSS</a>
      				</p>
    			</div>   
    		</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
