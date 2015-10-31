/**
 *
 *
 * Copyright (c) 2015 Angel Chrystian Torres
 * @author Angel Chrystian Torres
 * @date 29/10/15
 * @website elangelito.mx
 * @Description
 *  This component takes a number and returns a string representation of the number.
 *  It can convert from 1 to 999999999
 *
 * How to use:
 * 1. Create the object, no parameters will convert in spanish if you want it in english pass the first parameter as 'english'
 *   c = new numberToTextConverter();
 *
 * 2. Call the convert function
 *   result = c.convert( 1999 ); //mil novecientos noventa y nueve
 *   result = c.convert( 1999.50, true ); //mil novecientos novena y nueve 50/100 MX
 *
 * 3. Language can be changed after object is created
 *   c.setLanguage('english');
 *   c.setCurrency('USD');
 *   result = c.convert( 1999 ); //one thousand nine hundred and ninetynine
 *   result = c.convert( 1999, true ); //one thousand nine hundred and ninetynine USD
 **/
component displayname="Number to Text Converter" accessors=true {
	property name="language" default="spanish";
	property name="currency" default="MX";


/**@Displayname init
 * Constructor
 * ======================================================================================================
 **/
    public any function init( string language = "spanish", string currency = "MX" ){

       variables.language = arguments.language;
       variables.currency = arguments.currency;


        //Valid values for language are spanish|english
        if( not listFindNoCase( 'spanish,english', variables.language ) ){
        	throw('Language configuration error', 'Valid languages are spanish|english' );
        }

    	return this;
    }

/**@Displayname convert
 * Converts the number to a string
 * ======================================================================================================
 **/
    public string function convert( required numeric value, boolean appendCurrency = false ){
    	//Final result variable
    	var result = '';
    	var integer = '';
    	var decimals = '';

    	//Number without sign
    	arguments.value = abs( arguments.value );

    	//Split the integer and decimal parts
    	integer = listFirst( arguments.value, '.' );
    	var point = find( '.', arguments.value );

        //Decimal part exists
        if( point neq 0 ){
        	decimals = listLast( arguments.value, '.' );
        	if( len(decimals) eq 1 ){
                decimals = '#decimals#0/100';
        	}
        	else{
        		decimals = '#decimals#/100';
        	}
        }

    	//Get the integer part
    	result = getIntegerPart( integer ) & ' ' & decimals;

    	//Append currency if required
        if( arguments.appendCurrency ){
        	result = result & ' '  & variables.currency;
        }
        try{
        	return trim( result );
        }
        catch( any e ){
        	return( arguments.value );
        }

    }

/**@Displayname Get integer Part
 * Get the text equivalent of the integer part
 * ======================================================================================================
 **/
    private string function getIntegerPart( required numeric integer ){
    	var length = len( arguments.integer );

    	//Get the text according to the lenght of the argument
    	switch( length ){
    		case 1:
    		  return getUnits( arguments.integer );
    		  break;

    		case 2:
    		  return getTens( arguments.integer );
    		  break;

    		case 3:
    		  return getHundreds( arguments.integer );
    		  break;

    		case 4:
    		case 5:
    		case 6:
    		  return getThousands( arguments.integer );
    		  break;

    		default:
    		  return getMillions( arguments.integer );
    		  break;
    	}

    }

/**@Displayname Get Units
 * Get the equivalent text for units
 * ======================================================================================================
 **/
    private any function getUnits( required numeric value ){
    	var result = '';

    	switch( variables.language ){
    		case 'spanish':
	 		  //Spanish conversion
	 		  switch( arguments.value ){
	 		      case 1:
	 		          result = 'un';
	 		          break;
	 		      case 2:
	 		          result = 'dos';
	 		          break;
	 		      case 3:
	 		          result = 'tres';
	 		          break;
	 		      case 4:
	 		          result = 'cuatro';
	 		          break;
	 		      case 5:
	 		          result = 'cinco';
	 		          break;
	 		      case 6:
	 		          result = 'seis';
	 		          break;
	 		      case 7:
	 		          result = 'siete';
	 		          break;
	 		      case 8:
	 		          result = 'ocho';
	 		          break;
	 		      case 9:
	 		          result = 'nueve';
	 		          break;
	 		  }
	 		  break;
    		  //--End spanish conversion


    		  case 'english':
    		      //English conversion
    		      switch( arguments.value ){
	                  case 1:
	                      result = 'one';
	                      break;
	                  case 2:
	                      result = 'two';
	                      break;
	                  case 3:
	                      result = 'three';
	                      break;
	                  case 4:
	                      result = 'four';
	                      break;
	                  case 5:
	                      result = 'five';
	                      break;
	                  case 6:
	                      result = 'six';
	                      break;
	                  case 7:
	                      result = 'seven';
	                      break;
	                  case 8:
	                      result = 'eight';
	                      break;
	                  case 9:
	                      result = 'nine';
	                      break;
	              }
	              break;
	              //--End english conversion


    	}

    	return result;
    }

/**@Displayname Get Tens
 * Get the text equivalent for tens
 * ======================================================================================================
 **/
    private string function getTens( required numeric value ){
    	var result = '';
    	var lft = left( arguments.value, 1 );
    	var rgt = right( arguments.value, 1 );

    	switch( variables.language ){
    		case 'spanish':
    		  //Spanish conversion
    		  if( lft eq 1 ){
    		  	switch( arguments.value ){
    		  		case 10:
    		  		  result = 'diez';
    		  		  break;
    		  		case 11:
    		  		  result = 'once';
    		  		  break;
    		  		case 12:
                      result = 'doce';
                      break;
                    case 13:
                      result = 'trece';
                      break;
                    case 14:
                      result = 'catorce';
                      break;
                    case 15:
                      result = 'quince';
                      break;
                    case 16:
                      result = 'dieciseis';
                      break;
                    case 17:
                      result = 'diecisiete';
                      break;
                    case 18:
                      result = 'dieciocho';
                      break;
                    case 19:
                      result = 'diecinueve';
                      break;
    		  	}
    		  }
    		  else if( lft eq 2 ){
    		  	if( rgt eq 0 ){
    		  		result = 'veinte';
    		  	}
    		  	else{
    		  		result = 'veinti' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 3 ){
    		  	if( rgt eq 0 ){
    		  		result = 'treinta';
    		  	}
    		  	else{
    		  		result = 'treinta y ' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 4 ){
    		  	if( rgt eq 0 ){
    		  		result = 'cuarenta';
    		  	}
    		  	else{
    		  		result = 'cuarenta y ' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 5 ){
    		  	if( rgt eq 0 ){
    		  		result = 'cincuenta';
    		  	}
    		  	else{
    		  		result = 'cincuenta y ' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 6 ){
    		  	if( rgt eq 0 ){
    		  		result = 'sesenta';
    		  	}
    		  	else{
    		  		result = 'sesenta y ' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 7 ){
    		  	if( rgt eq 0 ){
    		  		result = 'setenta';
    		  	}
    		  	else{
    		  		result = 'setenta y ' & getUnits( rgt );
    		  	}
    		  }
    		  else if( lft eq 8 ){
                if( rgt eq 0 ){
                    result = 'ochenta';
                }
                else{
                    result = 'ochenta y ' & getUnits( rgt );
                }
              }
              else if( lft eq 9 ){
                if( rgt eq 0 ){
                    result = 'noventa';
                }
                else{
                    result = 'noventa y ' & getUnits( rgt );
                }
              }
    		  break;
    		  //--End spanish conversion

    		  case 'english':
	              //English conversion
	              if( lft eq 1 ){
	                switch( arguments.value ){
	                    case 10:
	                      result = 'ten';
	                      break;
	                    case 11:
	                      result = 'eleven';
	                      break;
	                    case 12:
	                      result = 'twelve';
	                      break;
	                    case 13:
	                      result = 'thirteen';
	                      break;
	                    case 14:
	                      result = 'fourteen';
	                      break;
	                    case 15:
	                      result = 'fifteen';
	                      break;
	                    case 16:
	                      result = 'sixteen';
	                      break;
	                    case 17:
	                      result = 'seventeen';
	                      break;
	                    case 18:
	                      result = 'eighteen';
	                      break;
	                    case 19:
	                      result = 'nineteen';
	                      break;
	                }
	              }
	              else if( lft eq 2 ){
	                if( rgt eq 0 ){
	                    result = 'twenty';
	                }
	                else{
	                    result = 'twenty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 3 ){
	                if( rgt eq 0 ){
	                    result = 'thirty';
	                }
	                else{
	                    result = 'thirty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 4 ){
	                if( rgt eq 0 ){
	                    result = 'fourty';
	                }
	                else{
	                    result = 'fourty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 5 ){
	                if( rgt eq 0 ){
	                    result = 'fifty';
	                }
	                else{
	                    result = 'fifty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 6 ){
	                if( rgt eq 0 ){
	                    result = 'sixty';
	                }
	                else{
	                    result = 'sixty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 7 ){
	                if( rgt eq 0 ){
	                    result = 'seventy';
	                }
	                else{
	                    result = 'seventy' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 8 ){
	                if( rgt eq 0 ){
	                    result = 'eighty';
	                }
	                else{
	                    result = 'eighty' & getUnits( rgt );
	                }
	              }
	              else if( lft eq 9 ){
	                if( rgt eq 0 ){
	                    result = 'ninety';
	                }
	                else{
	                    result = 'ninety' & getUnits( rgt );
	                }
	              }
              break;
              //--End english conversion
    	}

    	return result;
    }

/**@Displayname Get Hundreds
 * Get the text convertion for hundreds
 * ======================================================================================================
 **/
    private any function getHundreds( required numeric value ){
    	var result = '';
    	var lft = left( arguments.value, 1 );
    	var middle = mid( arguments.value, 2, 1 );
    	var rgt = right( arguments.value, 1 );
    	var tens = right( arguments.value, 2 );

    	switch( variables.language ){
    		//Spanish conversion
    		case 'spanish':
    		  if( lft eq 1 and middle eq 0 and rgt eq 0 ){
    		    result = 'cien';
              }
              else if( lft eq 1 and middle eq 0 ){
              	result = 'ciento ' & getUnits( rgt );
              }
              else if( lft eq 1 ){
              	result = 'ciento ' & getTens( tens );
              }
              else if( lft eq 2 and middle eq 0 and rgt eq 0 ){
                result = 'doscientos';
              }
              else if( lft eq 2 and middle eq 0 ){
                result = 'doscientos ' & getUnits( rgt );
              }
              else if( lft eq 2 ){
                result = 'doscientos ' & getTens( tens );
              }
              else if( lft eq 3 and middle eq 0 and rgt eq 0 ){
                result = 'trescientos';
              }
              else if( lft eq 3 and middle eq 0 ){
                result = 'trescientos ' & getUnits( rgt );
              }
              else if( lft eq 3 ){
                result = 'trescientos ' & getTens( tens );
              }
              else if( lft eq 4 and middle eq 0 and rgt eq 0 ){
                result = 'cuatrocientos';
              }
              else if( lft eq 4 and middle eq 0 ){
                result = 'cuatrocientos ' & getUnits( rgt );
              }
              else if( lft eq 4 ){
                result = 'cuatrocientos ' & getTens( tens );
              }
              else if( lft eq 5 and middle eq 0 and rgt eq 0 ){
                result = 'quinientos';
              }
              else if( lft eq 5 and middle eq 0 ){
                result = 'quinientos ' & getUnits( rgt );
              }
              else if( lft eq 5 ){
                result = 'quinientos ' & getTens( tens );
              }
              else if( lft eq 6 and middle eq 0 and rgt eq 0 ){
                result = 'seiscientos';
              }
              else if( lft eq 6 and middle eq 0 ){
                result = 'seiscientos ' & getUnits( rgt );
              }
              else if( lft eq 6 ){
                result = 'seiscientos ' & getTens( tens );
              }
              else if( lft eq 7 and middle eq 0 and rgt eq 0 ){
                result = 'setecientos';
              }
              else if( lft eq 7 and middle eq 0 ){
                result = 'setecientos ' & getUnits( rgt );
              }
              else if( lft eq 7 ){
                result = 'setecientos ' & getTens( tens );
              }
              else if( lft eq 8 and middle eq 0 and rgt eq 0 ){
                result = 'ochocientos';
              }
              else if( lft eq 8 and middle eq 0 ){
                result = 'ochocientos ' & getUnits( rgt );
              }
              else if( lft eq 8 ){
                result = 'ochocientos ' & getTens( tens );
              }
              else if( lft eq 9 and middle eq 0 and rgt eq 0 ){
                result = 'novecientos';
              }
              else if( lft eq 9 and middle eq 0 ){
                result = 'novecientos ' & getUnits( rgt );
              }
              else if( lft eq 9 ){
                result = 'novecientos ' & getTens( tens );
              }
    		  break;
    		  //--End spanish conversion

    		//English conversion
            case 'english':
              if( lft eq 1 and middle eq 0 and rgt eq 0 ){
                result = 'one hundred';
              }
              else if( lft eq 1 and middle eq 0 ){
                result = 'one hundred and ' & getUnits( rgt );
              }
              else if( lft eq 1 ){
                result = 'one hundred and ' & getTens( tens );
              }
              else if( lft eq 2 and middle eq 0 and rgt eq 0 ){
                result = 'two hundred';
              }
              else if( lft eq 2 and middle eq 0 ){
                result = 'two hundred and ' & getUnits( rgt );
              }
              else if( lft eq 2 ){
                result = 'two hundred and ' & getTens( tens );
              }
              else if( lft eq 3 and middle eq 0 and rgt eq 0 ){
                result = 'three hundred';
              }
              else if( lft eq 3 and middle eq 0 ){
                result = 'three hundred and ' & getUnits( rgt );
              }
              else if( lft eq 3 ){
                result = 'three hundred and ' & getTens( tens );
              }
              else if( lft eq 4 and middle eq 0 and rgt eq 0 ){
                result = 'four hundred';
              }
              else if( lft eq 4 and middle eq 0 ){
                result = 'four hundred and ' & getUnits( rgt );
              }
              else if( lft eq 4 ){
                result = 'four hundred and ' & getTens( tens );
              }
              else if( lft eq 5 and middle eq 0 and rgt eq 0 ){
                result = 'five hundred';
              }
              else if( lft eq 5 and middle eq 0 ){
                result = 'five hundred and ' & getUnits( rgt );
              }
              else if( lft eq 5 ){
                result = 'five hundred and ' & getTens( tens );
              }
              else if( lft eq 6 and middle eq 0 and rgt eq 0 ){
                result = 'six hundred';
              }
              else if( lft eq 6 and middle eq 0 ){
                result = 'six hundred and ' & getUnits( rgt );
              }
              else if( lft eq 6 ){
                result = 'six hundred and ' & getTens( tens );
              }
              else if( lft eq 7 and middle eq 0 and rgt eq 0 ){
                result = 'seven hundred';
              }
              else if( lft eq 7 and middle eq 0 ){
                result = 'seven hundred and ' & getUnits( rgt );
              }
              else if( lft eq 7 ){
                result = 'seven hundred and ' & getTens( tens );
              }
              else if( lft eq 8 and middle eq 0 and rgt eq 0 ){
                result = 'eight hundred';
              }
              else if( lft eq 8 and middle eq 0 ){
                result = 'eight hundred and ' & getUnits( rgt );
              }
              else if( lft eq 8 ){
                result = 'eight hundred and ' & getTens( tens );
              }
              else if( lft eq 9 and middle eq 0 and rgt eq 0 ){
                result = 'nine hundred';
              }
              else if( lft eq 9 and middle eq 0 ){
                result = 'nine hundred and ' & getUnits( rgt );
              }
              else if( lft eq 9 ){
                result = 'nine hundred and ' & getTens( tens );
              }
              break;
              //--End spanish conversion
    	}

    	return result;
    }

/**@Displayname Get Thousands
 * Get the text equivalen for thousands
 * ======================================================================================================
 **/
    private string function getThousands( required numeric value ){
    	var result = '';
    	var hundreds = right( arguments.value, 3 );
    	var thousands = left( arguments.value, len( arguments.value ) - 3 );

    	if( left( hundreds, 1 ) eq '0' ){
    		hundreds = right( hundreds, 2 );
    	}

    	switch( variables.language ){
    		case 'spanish':
    		  result = getIntegerPart( thousands ) & ' mil ' & getIntegerPart( hundreds );
    		  break;
    		case 'english':
              result = getIntegerPart( thousands ) & ' thousand ' & getIntegerPart( hundreds );
              break;
    	}

    	return result;
    }

/**@Displayname Get millions
 * Get text equivalent for millions
 * ======================================================================================================
 **/
    private string function getMillions( required numeric value ){
    	var result = '';
    	var hundreds = right( arguments.value, 3 );
    	var millions = left( arguments.value, len( arguments.value ) - 6 );
    	var thousands = mid( arguments.value, len( millions) + 1, 3 );

    	if( left( thousands, 2 ) eq '00' ){
    		thousands = right( thousands, 1 );
    	}
    	else if( left( thousands , 1 ) eq '0' ){
    		thousands = right( thousands, 2 );
    	}

    	if( left( hundreds, 1 ) eq '0' ){
    		hundreds = right( hundreds, 2 );
    	}
    	else if( left( hundreds, 2 ) eq '00' ){
    		hundreds = right( hundreds, 1 );
    	}

    	switch( variables.language ){
    		case 'spanish':
		    	if( len( millions ) eq 1 and left( millions, 1 ) eq '1' and thousands eq '000' and hundreds eq '00' ){
		            result = getIntegerPart( millions ) & ' millón';
		        }
		        else if( len( millions ) eq 1 and left( millions, 1 ) eq '1' ){
		            result = getIntegerPart( millions ) & ' millón ' & getIntegerPart( thousands ) & ' mil ' & getIntegerPart( hundreds );
		        }
		        else if( len( millions ) eq 1 and left( millions, 1) gt 1 and thousands eq '000' and hundreds eq '00' ){
		        	result = getIntegerPart( millions ) & ' millones';
		        }
		        else{
		        	result = getIntegerPart( millions ) & ' millones ' & getIntegerPart( thousands ) & ' mil ' & getIntegerPart( hundreds );
		        }
    		    break;

    		case 'english':
    		    if( len( millions ) eq 1 and left( millions, 1 ) eq '1' and thousands eq '000' and hundreds eq '00' ){
                    result = getIntegerPart( millions ) & ' million';
                }
                else if( len( millions ) eq 1 and left( millions, 1 ) eq '1' ){
                    result = getIntegerPart( millions ) & ' million ' & getIntegerPart( thousands ) & ' thousand ' & getIntegerPart( hundreds );
                }
                else if( len( millions ) eq 1 and left( millions, 1) gt 1 and thousands eq '000' and hundreds eq '00' ){
                    result = getIntegerPart( millions ) & ' millions';
                }
                else{
                    result = getIntegerPart( millions ) & ' millions ' & getIntegerPart( thousands ) & ' thousand ' & getIntegerPart( hundreds );
                }
                break;
    	}

    	return result;
    }


}