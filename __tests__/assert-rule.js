'use strict';

const fs = require('fs');

const ruleId = process.argv[2];
let raw = '';

try {
    raw = fs.readFileSync(0, 'utf8');
} catch (err) {
    process.stderr.write('Could not read ESLint JSON output.\n');
    process.exit(2);
}

let results;
try {
    results = JSON.parse(raw);
} catch (err) {
    process.stderr.write(
        'ESLint did not produce valid JSON. Install eslint as a dev dependency and add a configuration file.\n'
    );
    process.exit(2);
}

if (!Array.isArray(results)) {
    process.stderr.write('Unexpected ESLint JSON format.\n');
    process.exit(2);
}

function isExpectedRule(reported) {
    return reported === ruleId
        || reported === `@stylistic/${ruleId}`
        || reported === `@stylistic/js/${ruleId}`;
}

const reported = [];
for (const file of results) {
    for (const message of file.messages || []) {
        reported.push(message.ruleId);
    }
}

if (reported.some(isExpectedRule)) {
    process.exit(0);
}

const unique = [...new Set(reported.filter(Boolean))];
process.stderr.write(
    `Expected rule "${ruleId}" to be reported. Reported rules: ${
        unique.length ? unique.join(', ') : '(none)'
    }\n`
);
process.exit(1);
