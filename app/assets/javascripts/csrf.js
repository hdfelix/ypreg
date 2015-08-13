/*define( ['jquery'], function ( $ ) {
 var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

 $.ajaxSetup( {
 beforeSend: function ( xhr ) {
 xhr.setRequestHeader( 'X-CSRF-Token', token );
 }
 });

 return token;
 });*/
$(document).ready(function(){
    (function() {
        if ($) {
            var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );
            console.log($( 'meta[name="csrf-token"]' ));
            console.log($( 'meta[name="csrf-token"]' ).attr( 'content' ));
            console.log(token);
            $.ajaxSetup( {
                beforeSend: function ( xhr ) {
                    xhr.setRequestHeader( 'X-CSRF-Token', token );
                }
            });
        }
    })();
});