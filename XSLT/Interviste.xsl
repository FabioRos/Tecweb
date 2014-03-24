<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method='html' version='1.0' encoding='UTF-8' indent='yes'/>
    <xsl:template match="intervista[1]">
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
                <title>Interviste - <xsl:value-of select="titolo"/></title>               
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
                                <p xml:lang="eng">Home</p>
                            </a>
                        </li>
                        <li>
                            <a href="../cgi-bin/show.chi?type=n">
                                <span xml:lang="eng">News</span>
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
                    <a href="../cgi-bin/show.chi?type=i" class="ribbon IntervisteRibbon">Interviste</a>
                    <h1>
                        <xsl:value-of select="titolo"/>
                    </h1>
                    <a class="help" href="#sidebar">salta contenuto</a>

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
                    <h3 id="interlocutore">Abbiamo intervistato: <xsl:value-of select="intervistato"/></h3>
                    <p id="descrizione">
                        <xsl:value-of select="descrizione"/>
                    </p>
                    
                    <p id="Titologallery">GALLERY</p>

                                       
                    <xsl:if test="galleria">
                        <div id="gallery" >
                            <ul>
                                <xsl:if test="//galleria/foto[1]">
                                    <li id="img1" class="active">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[1]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[1]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>

                                <xsl:if test="//galleria/foto[2]">
                                    <li id="img2" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[2]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[2]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[3]">
                                    <li id="img3" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[3]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[3]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[4]">
                                    <li id="img4" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[4]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[4]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                <xsl:if test="//galleria/foto[5]">
                                    <li id="img5" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[5]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[5]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[6]">
                                    <li id="img6" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[6]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[6]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[7]">
                                    <li id="img7" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[7]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[7]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[8]">
                                    <li id="img8" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[8]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[8]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                                
                                <xsl:if test="//galleria/foto[9]">
                                    <li id="img9" class="hidden">
                                        <xsl:element name="img">
                                            <xsl:attribute name="class">slide</xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:copy-of select="//galleria/foto[9]/srcPath/node()" />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:copy-of select="//galleria/foto[9]/titolo/node()" />
                                            </xsl:attribute>
                                        </xsl:element>
                                    </li>
                                </xsl:if>
                            </ul>
                            
                            <div id="prev">
                                <button class="galleryButton" title="Precedente" onclick="previous();" type="button">Precedente</button>
                            </div>
                            <div id="next">
                                <button class="galleryButton" title="Prossima" onclick="next();" type="button">Prossima</button>
                            </div>
                        </div>
                        
                        <ol id="controlnav" >
                            <xsl:if test="//galleria/foto[1]">
                                <li id="t1" class="activenav">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[1]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[1]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(1)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[2]">
                                <li id="t2">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[2]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[2]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(2)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[3]">
                                <li id="t3">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[3]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[3]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(3)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[4]">
                                <li id="t4">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[4]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[4]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(4)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[5]">
                                <li id="t5">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[5]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[5]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(5)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[6]">
                                <li id="t6">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[6]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[6]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(6)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[7]">
                                <li id="t7">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[7]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[7]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(7)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[8]">
                                <li id="t8">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[8]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[8]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(8)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                            <xsl:if test="//galleria/foto[9]">
                                <li id="t9">
                                    <xsl:element name="img">
                                        <xsl:attribute name="class">tnail</xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:copy-of select="//galleria/foto[9]/srcPath/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:copy-of select="//galleria/foto[9]/titolo/node()" />
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">change(9)</xsl:attribute>
                                    </xsl:element>
                                </li>
                            </xsl:if>
                            
                        </ol>
                        
                        
                        
                        
                        
                    </xsl:if>
                   
                        
                     
                    <!--
                    <xsl:for-each select="galleria/foto">
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:copy-of select="srcPath/node()" />
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:copy-of select="titolo/node()" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                    -->
                </div>
                <div id="footer">
                    <a class="help" href="#header">salta testo a fine pagina</a>
                    <p>copy; 2014 Music Break All Right Reserved. | 
                        <a href="../public_html/info.html"> Chi siamo</a> | 
                        <a href="http://it.wikipedia.org/wiki/Copyright">Condizioni d'uso</a> | 
                        <a href="../public_html/contact.html"> Contatti</a> 
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>