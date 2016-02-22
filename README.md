# nyymi

Nyymi on rekrytointipalvelu, joka piilottaa kaikki hakijoiden iän, sukupuolen ja etnisen taustan kertovat tiedot. Tutkitusti yli 50-vuotiaiden sekä maahanmuuttajien on vaikeampi saada töitä, joten Nyymi on tarkoitettu lieventämään työnantajien ennakkoluuloja rekrytoinnissa. 

Nyymissä on kaksi käyttäjätyyppiä, yrityksen ylläpitäjä sekä työnhakija. Yrityksen ylläpitäjä voi tietysti myös hakea töitä. Sovellus itsessään on käyttöohje. 

##Tekninen toteutus

Sovelluksessa on sekä one-to-many että many-to-many-yhteyksiä (yritys - adminkäyttäjä). 

##Ulkoasu

Käytin ulkoasussa http://www.free-css.com/free-css-templates/page193/spot css-templatea itse muokattuna. 

## Yksityisyydenhallinta

Yksityisenhallinnassa käytetään deklaratiivisen autentikoinnin gemiä CanCania (https://github.com/ryanb/cancan ). Se helpottaa sen määrittelyä, mille sivuille mitkäkin käyttäjän saavat mennä. 

##Kielilokalisointi

ei vielä tehty

## Muut ulkoiset gemit
JSONin generoinnin ehdollisuuteen käytin jbuilder-gemiä. (https://github.com/rails/jbuilder). 

##Testausuunnitelma 

###Yksikkötestaus

Yksikkötestejä on User, Company ja OpenJob -olioiden validointiin sekä open_jobs.json -vastauksesta varmistamiseen, ettei vanhentuneita avoimia työpaikkoja ole mukana listauksessa. (HUOM tee tämä) 

###Capybara -testaus

Kaikkien luokkien kaikki sivut testataan erityisesti yksityisyyden takaamiseksi. 

###Company

<b>New-sivu</b>
* Jos käyttäjä ei ole kirjautunut, cancan estää pääsemästä new -sivulle t

<b>Index-sivu</b>
* Jos käyttäjä ei ole kirjautunut, Luo uusi yritys -nappia ei ole t
* Kun käyttäjä luo yrityksen kirjautuneena, hänestä tulee ylläpitäjä. t

<b>Edit-sivu: </b>
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole kirjautunut lainkaan
* Käyttäjä pääsee edit -sivulle ja muokatut tiedot tulevat näkyviin yrityksen sivulla muokkaukden jälkeen

<b>Administration -sivu</b>
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole kirjautunut lainkaan
* Käyttäjä pääsee administration -sivulle, jos hän on ylläpitäjä

<b>Yrityksen poistaminen</b>
* Käyttäjä ei voi poistaa yritystä, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei voi poistaa yritystä, jos hän ei ole kirjautunut lainkaan
* Käyttäjä voi poistaa yrityksen kirjautuneena

<b>Administration -sivulle vievä nappi</b>
* Yrityksen sivulla ei näy administration -nappia (vie kyseiselle sivulle), jos käyttäjä on kirjautunut mutta ei ole ylläpitäjä
* Yrityksen sivulla ei näy administration -nappia, jos käyttäjä ei ole kirjautunut lainkaan
* Yrityksen sivulla näkyy administration -nappi jos käyttäjä on ylläpitäjä t

<b>About -sivu</b>
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautuneena t
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautumattomana  t

###User

<b>Rekisteröityminen:</b>
* Kun käyttäjä ei ole kirjautunut sisään, navigaatiopalkissa näkyy Rekisteröidy -ja Kirjaudu sisään -napit t
* Käyttäjä kirjautuu automaattisesti sisään rekisteröityessä t
* Kun käyttäjä on kirjautunut sisään, navigaatiopalkissa näkyy Kirjaudu ulos -nappi t

<b>Show-sivu</b>
* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautuneena
* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautumattomana 

<b>Poistaminen</b>
* Käyttäjä ei voi poistaa muita käyttäjiä kirjautumattomana
* Käyttäjä ei voi poistaa muita käyttäjiä kirjautuneena
* Käyttäjä voi poistaa itsensä

<b>Edit -sivu</b>
* Käyttäjä ei voi muokata muiden käyttäjien tietoja kirjautumattomana
* Käyttäjä ei voi muokata muiden käyttäjien tietoja kirjautuneena
* Käyttäjä voi muokata omia tietojaan 

###Open job

###Application

