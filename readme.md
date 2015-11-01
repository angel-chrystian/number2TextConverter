#Number 2 Text Converter

This component takes a number and returns a string representation of the number.
It can convert from 1 to 999999999

##LICENSE
The MIT License (MIT)

##IMPORTANT LINKS

**Source**
- https://github.com/angel-chrystian/number2TextConverter

**Documentation**
- http://elangelito.mx/librerias/number-2-text-converter

##SYSTEM REQUIREMENTS
- Railo 4+
- Lucee 4.5+
- ColdFusion 10+

# INSTRUCTIONS
Just drop into accesible folder in your server


## How to use

1. Create an instance of the object
```
c = new number2TextConverter();
```
2. Call the convert function with the number you want to convert
```
result = c.convert( 1999 ); //mil novecientos noventa y nueve
result = c.convert( 1999.50, true ); //mil novecientos novena y nueve 50/100 MX
//Change the currency
c.setCurrency( 'pesos' );
result = c.convert( 1999.50, true ); //mil novecientos novena y nueve 50/100 pesos

//Language can be changed without creating another object just call setLanguage function
c.setLanguage('english');
c.setCurrency('USD');
result = c.convert( 1999 ); //one thousand nine hundred and ninetynine
result = c.convert( 1999, true ); //one thousand nine hundred and ninetynine USD
c.setCurrency( 'dollars' );
result = c.convert( 1999.50, true ); //one thousand nine hundred and ninetynine 50/100 dollars
```

