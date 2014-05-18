class mypackage 

console.log "hello-world"
#This function is available on both the client and the server.
mypackage.greet = ( name )  -> 
    console.log("Hi. I'm " + name );


#Everything in here is only run on the server.

mypackage.greet "SERVER"


#Everything in here is only run on the client.

mypackage.greet "CLIENT"

