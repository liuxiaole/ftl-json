var os = require('os');
var spawn = require('child_process').spawn;

var run;

if(os.platform().indexOf('win32') !== -1) {
    run = spawn("cmd",["/c",".\\test\\test.bat"]);
} else {
    run = spawn("sh",["./test/test.sh"]);
}

run.stdout.on('data', (data) => {
  console.log(data.toString());
});

run.stderr.on('data', (data) => {
  console.log(data.toString());
});

run.on('close', (code) => {
    process.exit(code);
});