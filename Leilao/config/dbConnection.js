//banco
const mysql = require("mysql");

 function _createConnection(){
    return mysql.createConnection({
        host:'localhost',
        user :'user',
        password:'senha',
        database:'leilao',
        port:3306
    });
}

//const mysql = require( 'mysql' );
class Database {
    constructor( ) {
        this.connection = mysql.createConnection( {
                host:'localhost',
                user :'user',
                password:'senha',
                database:'leilao',
                port:3306 }
            );
    }
    query( sql, args ) {
        return new Promise( ( resolve, reject ) => {
            this.connection.query( sql, args, ( err, rows ) => {
                if ( err )
                    return reject( err );
                resolve( rows );
            } );
        } );
    }
    close() {
        return new Promise( ( resolve, reject ) => {
            this.connection.end( err => {
                if ( err )
                    return reject( err );
                resolve();
            } );
        } );
    }
}

 module.exports= Database; 

