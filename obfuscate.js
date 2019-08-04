// Require Filesystem module
var fs = require("fs");

// Require the Obfuscator Module
var JavaScriptObfuscator = require('javascript-obfuscator');
const obfuscateFile = ['./index','./cloud/main'];
// Read the file of your original JavaScript Code as text
obfuscateFile.forEach(x => {
    fs.readFile(x+'.js', "UTF-8", function(err, data) {
        if (err) {
            throw err;
        }

        // Obfuscate content of the JS file
        var obfuscationResult = JavaScriptObfuscator.obfuscate(data);
        
        // Write the obfuscated code into a new file
        fs.writeFile(x+'-obfuscated.js', obfuscationResult.getObfuscatedCode() , function(err) {
            if(err) {
                return console.log(err);
            }
        
            console.log("The file was saved!");
        });
    });
});
