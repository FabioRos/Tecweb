<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>
    <xsl:template match="evento">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it" lang="it">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <meta name="author" content="Fabio Ros, Valerio Burlin, Stefano Munari, Alberto Andeliero"/>
                <meta name="language" content="italian it"/>
                <meta name="rating" content="safe for kids" />
                <meta name="description" content="Il portale di news, articoli, recensioni ed eventi dedicato alla musica"/>
                <meta name="keywords" content="musica, news, news musicali, notizie, album"/>
                <xsl:element name="meta">
                    <xsl:attribute name='name'>keywords</xsl:attribute>
                    <xsl:attribute name='content'>
                        <xsl:for-each select="tag">
                            <xsl:copy-of select="node()" />&#160;
                        </xsl:for-each>
                    </xsl:attribute>
                </xsl:element>
                <meta name="robots" content="all" />
                <link rel="icon" href="../public_html/img/fav.ico" type="image/icon" />
                <link rel="stylesheet" type="text/css" media="handheld, screen" href="../public_html/css/screen.css"/>
                <link rel="stylesheet" type="text/css" media="print" href="../public_html/css/print.css"/>
                <link rel="stylesheet" type="text/css" media="speech" href="../public_html/css/aural.css"/>
                <title>Evento - <xsl:value-of select="titolo"/></title>
            </head>
            <body>
                <div id="header">
                    <a class="help" href="#nav">salta intestazione</a>
                    <div id="title">
                        <a href="../cgi-bin/home.cgi">
                            <span id="logo" class="notAural">
                                <img src="../public_html/img/tazza-di-caffe.jpg" alt="Logo del sito Music Break"/>
                            </span>
                            <h1>
                                <span xml:lang="en">Music Break</span>
                            </h1>
                        </a>
                        <h2>Il portale di notizie dedicato alla musica</h2>
                    </div>
                </div>
                <div id="nav">
                    <a class="help" href="#contents">salta menù</a>
                    <ul>
                        <li>
                            <a href="../public_html/home.xml">
                                <p xml:lang="en">Home</p>
                            </a>
                        </li>
                        <li>
                            <a href="../cgi-bin/show.chi?type=n">
                                <span xml:lang="en">News</span>
                            </a>
                        </li>
                        <li>
                            <a href="../cgi-bin/show.chi?type=i">Interviste</a>
                        </li>
                        <li>
                            <a href="../cgi-bin/show.chi?type=r">Recensioni</a>
                        </li>
                        <li>
                            <a href="../cgi-bin/show.chi?type=e">Eventi</a>
                        </li>
                    </ul>
                    <div id="search">
                        <input type="text" id="text_field" value="" name="query"></input>
                        <input type="submit" id="button" alt="inserire una ricerca" value="Cerca"></input>
                        <input type="hidden" value="Home.html" name="sitesearch"></input>
                    </div> 
                </div>
                 <div id="contents" class="article_box">
                    <a href="../cgi-bin/show.chi?type=e" class="ribbon eventRibbon">Eventi</a>
                    <a class="help" href="#sidebar">salta contenuto</a>
                    <h1>
                        <xsl:value-of select="titolo"/>
                    </h1>
                    <h2>Scritto da <xsl:value-of select="editore/nome"/>&#160;
                        <xsl:value-of select="editore/cognome"/> il <xsl:value-of select="data"/>
                    </h2>
                    <ul class="tags">
                        <xsl:for-each select="tag">
                            <li>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">cgi-bin/searchtags.cgi?idtag=<xsl:copy-of select="string(@id)" /></xsl:attribute>
                                    <xsl:value-of select="node()"/>
                                </xsl:element>
                            </li>
                        </xsl:for-each>
                    </ul>
                    <xsl:element name="img">
                        <xsl:attribute name="class">article_img</xsl:attribute>
                        <xsl:attribute name='src'>
                            <xsl:copy-of select="foto/src/node()" />
                        </xsl:attribute>
                        <xsl:attribute name='alt'>
                            <xsl:copy-of select="foto/alt/node()" />
                        </xsl:attribute>
                    </xsl:element>
                    
                    <div id="informazioni">
                     <ul>
                         <li>Città: <strong><xsl:value-of select="luogo"/></strong></li>
                         <li>Ora Inizio: <strong><xsl:value-of select="OraInizio"/></strong></li>
                         <li>Ora Fine: <strong><xsl:value-of select="oraFine"/> </strong></li>
                         <li>Indirizzo: <strong><xsl:value-of select="indirizzo"/></strong></li>
                         <li>Prezzo: <strong><xsl:value-of select="prezzo"/></strong></li>
                         <li>Info email:<strong> <xsl:value-of select="email"/></strong></li>
                         <li>Telefono: <strong><xsl:value-of select="telefono"/></strong></li>
                     </ul>
                     </div>
                    
                   <p id="descrizione">
                        <xsl:value-of select="descrizione"/>
                    </p>
                   
                </div>
                <div id="footer">
                    <a class="help" href="#header">salta testo a fine pagina</a>
                    <p>copy; 2014 Music Break All Right Reserved. | 
                        <a href="../public_html/info.html"> Chi siamo</a> | 
                        <a href="http://it.wikipedia.org/wiki/Copyright">Condizioni d'uso</a> | 
                        <a href="../public_html/contact.html"> Contatti</a> | 
                        <a href="rss"> Feed RSS</a>
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>