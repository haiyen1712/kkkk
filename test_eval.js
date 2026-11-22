const fs = require('fs');
const html = fs.readFileSync('index.html', 'utf8');

// Extract evaluateAllRecords and parseNumberClean from index.html
const parseNumberCleanMatch = html.match(/function parseNumberClean[\s\S]*?^}/m);
const evaluateAllRecordsMatch = html.match(/function evaluateAllRecords[\s\S]*?^}/m);

console.log("parseNumberClean found:", !!parseNumberCleanMatch);
console.log("evaluateAllRecords found:", !!evaluateAllRecordsMatch);
