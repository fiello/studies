

async function invalid() : Promise<string> {
    throw new Error("fail");
}


async function randomize_exception() : Promise<string> {
    let alwaysThrow = await invalid();
    try {
        let val = Math.random() * 10;
        if (val > 5) {
            console.log("exception block with " + val )   
            throw new Error("bad");
        }

        console.log("passed exception block with " + val);
        return "good";
    } catch (err) {
        throw new Error("bad re-thrown");
    }
}

async function generate() {
    try {
        let promise = randomize_exception();
        promise.then(res => {
            console.log("Handled result: " + res);
        }).catch( err => {
            console.log("Catch chain: " + err);
        });
    } catch (err) {
        console.log("in outer exception block with " + err);
    }
}
generate();
