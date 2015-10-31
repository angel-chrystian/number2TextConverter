/**
* My BDD Test
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
        // all your suites go here.
        describe("A number to text converter", function(){

         c = new number2TextConverter();

         it("Can convert from number to text in spanish and English", function(){
              //In spanish
              expect( c.convert( 1 ) ).toBe( "un" );
              //In English
              c.setLanguage('english');
              expect( c.convert( 1 ) ).toBe( "one" );

              //In spanish
              c.setLanguage( 'spanish' );
              expect( c.convert( 16 ) ).toBe( "dieciseis" );
              expect( c.convert( 1000000 ) ).toBe('un millón');
              expect( c.convert( 2000000 ) ).toBe('dos millones');
              expect( c.convert( 1999.50, true ) ).toBe('un mil novecientos noventa y nueve 50/100 MX' );
              expect( c.convert( 1999.51 ) ).toBe('un mil novecientos noventa y nueve 51/100' );


              //In English
              c.setLanguage('english');
              expect( c.convert( 15 ) ).toBe( "fifteen" );


              var a = [];
              var ranges = [10,100,1000,100000,1000000,10000000,100000000,1000000000];

              for( var j = 1; j <= arrayLen(ranges); j++ ){
                  if( j eq 1 ){
                  	inicio = 1;
                  }
                  else{
                  	inicio = ranges[ j - 1 ];
                  }
                  fin = ranges[ j ];

	              for( var i = 1; i <= 10; i++ ){
	                temp = randRange( inicio, fin );
	                if( not arrayFind( a, temp ) ){
	                    arrayAppend( a, temp );
	                }
	              }

	              for( n in a ){
	                c.setLanguage('spanish');
	                resp.number = n;
	                resp.spanish = c.convert( n );
	                c.setLanguage('english');
	                resp.english = c.convert( n );
	                debug( duplicate( resp ) );
	              }

	              arrayClear( a );

              }



         });

        });
	}

}
