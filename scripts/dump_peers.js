function writePeersFile() {
	    console.log('=');
	    console.log(Date.now());
	    admin.peers.forEach(function(value){
		            if(value.enode.split('@')[1].split(':')[0] == '132.68.39.144'){
				                console.log("removed peer 132.68.39.144")
				                admin.removePeer(value.enode);
				            }
		            console.log(value.enode);
		        })
}
writePeersFile();
